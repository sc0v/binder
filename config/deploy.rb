# ==|== capistrano deployment configuration ================================
# Author: Meg Richards (mouse@cmu.edu)
# ==========================================================================

# Application name
set :application, "trailer"

# Multistage configuration
set :stages, %w(staging production)
set :default_stage, "staging"
require 'capistrano/ext/multistage'

# Remote machine options
set :user, "trailer"
set :group, "www-data"
set :use_sudo, true
set :default_shell, "/bin/bash"
set :default_environment, { 'PATH' => "/var/lib/gems/1.9.1/bin:$PATH" }
set :deploy_to, "/srv/rails/#{application}"
depend :remote, :directory, deploy_to

# Repository information
set :scm, :git
set :repository,  "https://github.com/stevemcquaid/boa.git"
set :deploy_via, :copy

# App configuration files not in source control
set :local_config_path, "/usr/local/etc/#{application}"
set :destination_config_path, deploy_to
set :local_config_files, ["#{File.join('config','initializers','secret_token.rb')}", "#{File.join('config','database.yml')}"]
depend :remote, :directory, local_config_path

# Bundler required to install other gems
depend :local, :command, "bundle"
set :bundle_flags, "--quiet"
require "bundler/capistrano"


# Nice simple sanity check task
task :uname do
  run "uname -a"
end


# ==|== deploy =============================================================
namespace :deploy do
  task :start do ; end
  task :stop do ; end

  desc "Reload mod_passenger"
  task :restart, :except => { :no_release => true }, :roles => :app do
    run "touch #{File.join(current_path,'tmp','restart.txt')}"
  end

  desc "Copy machine-specific configuration files into their proper place"
  task :copy_local_configs, :except => { :no_release => true }, :roles => :app do
    local_config_files.each do |c|
      run "ln -fs #{local_config_path}/#{c} #{release_path}/#{c}" 
    end
  end

  desc "Change log permissions to 0666"
  task :fix_log_permissions, :except => { :no_release => true }, :roles => :app do
    run "chmod 0666 #{shared_path}/log/*"
  end  

end

on :before, "deploy:restart", "deploy:fix_log_permissions", :only => "deploy:cold"

on :after, "deploy:copy_local_configs", "db:create", :only => "deploy:cold"

after "deploy:update_code", "deploy:copy_local_configs", "deploy:migrate"

# Cleanup old releases on deploy
after "deploy:restart", "deploy:cleanup"


# ==|== db =================================================================
namespace :db do

  desc "Create database associated with deployment environment"
  task :create, :except => { :no_release => true }, :roles => :db do
    run "cd #{current_path} && bundle exec rake db:create"
  end

  task :migrate, :except => { :no_release => true }, :roles => :db do
    run "cd #{current_path} && bundle exec rake db:migrate"
  end

end

# ==|== rails ==============================================================
# Excerpt from rails-recipes gem ( https://github.com/codesnik/rails-recipes )
namespace :rails do
  
  desc "Run rails console on remote app server"
  task :console do
    run_with_tty %W( rails console #{rails_env} )
  end
  
  desc "Run rails dbconsole on remote app server"
  task :dbconsole do 
    run_with_tty %W( rails dbconsole #{rails_env} )
  end
  
  def run_with_tty cmd
    server = find_servers(:roles => [:app]).first
    command  = %W( ssh -t -l #{user} #{server.host} )
    command += %W( cd #{current_path} && )
    command += Array(cmd)
    system *command
  end
end
