set :bundle_without, [:development, :test, :staging]
set :rails_env, 'production'
set :branch, :master
server 'trailer.springcarnival.org', :app, :web, :db, :primary => true

set :bundle_dir, ''
set :bundle_flags, '--system --quiet'
set :rvm_type, :system