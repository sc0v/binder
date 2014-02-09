source 'https://rubygems.org'
ruby '2.0.0'
gem 'rails', '4.0.2'

gem 'sass-rails', '~> 4.0.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'jquery-rails'
gem 'jbuilder', '~> 1.2'
gem 'bootstrap-sass', '>= 3.1.0'
gem 'simple_form'
gem 'therubyracer', :platform=>:ruby
gem 'omniauth'
gem 'omniauth-shibboleth'

# User and role management
gem 'cancan'
gem 'devise'
gem 'rolify', '~> 3.3.0.rc4'

# For LDAP calls to CMU's database
gem 'ruby-ldap'
gem 'activeldap', :require => 'active_ldap/railtie'

# For Card-lookup requests
gem 'rest-client'

# Document attachments
gem "carrierwave"

# For Pagniation
gem 'will_paginate'

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
  gem 'sqlite3'
  gem 'thin'
end

group :test do
  # Functional Test Framework (Capybara with Minitest
  #gem 'capybara'
  #gem 'minitest-spec-rails'
  gem 'minitest-wscolor'

  # Test Coverage
  gem 'simplecov'
  gem 'simplecov-rcov'

  # For mocking Web calls
  gem 'webmock'

  # For Improved Minitest Syntax
  gem 'shoulda'
  gem 'shoulda-matchers'

  # For Factories
  gem 'factory_girl_rails'
end

group :production do
  gem 'mysql2'
  gem 'passenger'
end
