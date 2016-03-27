source 'https://rubygems.org'
ruby '2.3.0'
gem 'rails', '4.2.6'
gem 'turbolinks'

gem 'sass-rails'
gem 'uglifier'
gem 'coffee-rails'
gem 'jquery-rails'
gem 'jbuilder'
gem 'bootstrap-sass'
gem 'simple_form'
gem 'therubyracer', :platform=>:ruby
gem 'omniauth'
gem 'omniauth-shibboleth'

# User and role management
gem 'cancancan'
gem 'devise'
gem 'rolify'

# For LDAP calls to CMU's database
gem 'ruby-ldap'
gem 'activeldap', :require => 'active_ldap/railtie'

# For Card-lookup requests
gem 'rest-client'

# For Capistrano deployment
group :development do
  gem 'capistrano-rbenv', require: false

  # bundler specific tasks in capistrano
  gem 'capistrano-bundler'

  # rails specific tasks in capistrano
  gem 'capistrano-rails'

  # passenger specific tasks in capistrano
  gem 'capistrano-passenger'
end

# Document attachments
gem "carrierwave"

# For Pagniation
gem 'will_paginate'
gem 'will_paginate-bootstrap'

gem 'possessive'
gem 'responders'

# Favicons
gem 'rails_real_favicon'

# Twilio for SMS
gem 'twilio-ruby'

group :development do
  # Automatically generate comments in models and such based on schema
  gem 'annotate'

  gem 'better_errors'
  gem 'binding_of_caller', :platforms=>[:mri_19, :mri_20, :rbx]
  gem 'quiet_assets'
  gem 'rails_layout'
  gem 'rails-erd'
  gem 'spring'
end

group :development, :test do
  gem 'thin'
end

group :development, :staging, :production do
  gem 'newrelic_rpm'
  gem 'mysql'
end

group :test do
  # Functional Test Framework (Capybara with Minitest
  #gem 'capybara'
  #gem 'minitest'
  #gem 'minitest-spec-rails'
  #gem 'minitest-wscolor'

  # For mocking Web calls
  gem 'webmock'

  # For Improved Minitest Syntax
  gem 'shoulda'
  gem 'shoulda-matchers'

  # For Factories
  gem 'factory_girl_rails'

  # For Travis
  gem 'rake'

  gem 'sqlite3'

  gem 'coveralls', require: false
end

group :staging, :production do
  gem 'passenger'
end
