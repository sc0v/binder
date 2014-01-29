set :bundle_without, [:test, :production]
set :rails_env, 'development'
set :branch, :master
server 'binder-d02.springcarnival.org', :app, :web, :db, :primary => true
