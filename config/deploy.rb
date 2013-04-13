set :domain, 'doorstop.wv.cc.cmu.edu'
set :stages, %w(development production)
set :default_stage, "production"
require 'capistrano/ext/multistage'

set :use_sudo, false
set :default_shell, "/bin/bash"

set :application, "trailerapp"
set :user, "root"

set :scm, 'git'
set :branch, 'master'
set :repository,  "https://github.com/sc0v/trailerapp.git"
set :deploy_to, "/opt/rails/#{application}"
set :deploy_via, :remote_cache
set :rails_env, 'production'
set :bundle_cmd, 'bundle --local'

task :uname do
  run "uname -a"
end

# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
    run "#{try_sudo} service apache2 restart"
  end

  task :secret_config, :except => { :no_release => true }, :role => :app do
    run "cp -f #{shared_path}/config/initializers/secret_token.rb #{current_path}/config/initializers/secret_token.rb"
  end
  task :db_config, :except => { :no_release => true }, :role => :app do
    run "cp -f #{shared_path}/config/database.yml #{current_path}/config/database.yml"
  end

  namespace :bundle do
    task :install do
      run "cd #{current_path} && RAILS_ENV=#{rails_env} bundle install"
    end
  end

  namespace :assets do
    task :precompile do
      run "cd #{current_path} && bundle exec rake assets:precompile RAILS_ENV=#{rails_env}"
    end
  end
end
after "deploy:update", "deploy:secret_config"
after "deploy:update", "deploy:db_config"
after "deploy:update", "deploy:bundle:install"
after "deploy:update", "deploy:assets:precompile"

