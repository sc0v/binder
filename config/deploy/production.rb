set :bundle_without, [:development, :test]
set :rails_env, 'production'
set :branch, :master
server 'binder-02.springcarnival.org', :app, :web, :db, :primary => true
