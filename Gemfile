source 'http://rubygems.org'
ruby '1.9.3'
gem 'rails', '3.2.13'
#gem 'sqlite3'

group :assets do
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
  gem 'therubyracer', :platform => :ruby
  gem "less-rails" #Sprockets (what Rails 3.1 uses for its asset pipeline) supports LESS
end

gem 'jquery-rails'

# ldap
#Flip the two gems below this when trying to generate...
#gem "twitter-bootstrap-rails"
gem "activeldap", :require => 'active_ldap/railtie'
gem 'net-ldap'

# erd
gem "rails-erd"

# document attachments
gem "carrierwave"

# Shibboleth
gem "omniauth"
gem "omniauth-shibboleth"

# Rest - For Card Lookup
gem 'rest-client'

gem 'cancan'
gem 'devise'

gem 'figaro'
gem 'rolify'

gem 'simple_form'

gem 'will_paginate'

#gem 'webrick', "~> 1.3.1"

group :test, :development, :staging, :production do
  gem 'pg'

  gem 'ci_reporter'
  
  # *** Start SQL Gems ***
  #gem 'sqlite3'
  gem 'activerecord-postgresql-adapter'
  # *** End SQL Gems ***
end

group :development, :test do
 #Gems for rspec & capybara
  gem 'rspec-rails', '~> 3.0.0.beta'
  gem 'database_cleaner', '1.0.1'
  gem 'launchy'
  gem 'capybara'

  # for Travis and CI
  gem 'simplecov', :require => false #code coverage
  gem 'simplecov-rcov', :require => false #code coverage
end

group :test do
  #gem 'rake'

  gem 'cucumber-rails', :require=>false
  gem 'email_spec'
  gem 'factory_girl_rails'


  gem 'minitest-spec-rails'
  gem 'minitest-wscolor'

  gem 'shoulda'
  gem 'shoulda-matchers'

  # For mocking the call to cardlookup
  gem 'webmock'

  gem 'coveralls', require: false
  # Pretty test Output
  gem 'turn', :require => false # Pretty printed test output
end

group :development do
  gem 'hirb' # pretty formatting for rails console
  gem 'better_errors'
  
  gem 'binding_of_caller', :platforms=>[:mri_19, :mri_20, :rbx]
 
  gem 'quiet_assets'
  gem 'rails_layout'
  
  gem 'spring'
  gem "capistrano", "2.15.5"
  # gem "ruby-activeldap-debug", "~> 0.7.4"

end  

group :staging do
  gem 'hirb' # pretty formatting for rails console
  gem 'populator3'
  
  gem 'passenger'
  
  gem 'quiet_assets'
end 

group :production do
  gem 'better_errors'
  gem 'passenger'
  gem 'quiet_assets'
end