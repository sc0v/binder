# frozen_string_literal: true
source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby File.read("#{Bundler.root}/.ruby-version").strip

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem 'rails', '~> 7.0.4', '>= 7.0.4.2'

# Use the Puma web server [https://github.com/puma/puma]
gem 'puma', '~> 5.0'

# Use JavaScript with ESM import maps [https://github.com/rails/importmap-rails]
gem 'importmap-rails'

# Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
gem 'turbo-rails'

# Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
gem 'stimulus-rails'

# Build JSON APIs with ease [https://github.com/rails/jbuilder]
gem 'jbuilder'

# Use Redis adapter to run Action Cable in production
# gem "redis", "~> 4.0"

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem "kredis"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
# gem "bcrypt", "~> 3.1.7"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', require: false

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
# gem "image_processing", "~> 1.2"

# Manage permissions
gem 'cancancan'

# Authenticate users with CMU Shibboleth
gem 'omniauth'
gem 'omniauth-rails_csrf_protection', '~> 1.0'
gem 'omniauth-saml', '>= 2.2.3'

# Lookup CMU users in LDAP
gem 'activeldap', require: 'active_ldap/railtie'
gem 'net-ldap'

# Connect to CMU's card service using SOAP
gem 'savon'

# Paginatation
gem 'pagy'

# Export zip file for charges
gem 'rubyzip'

# Font Awesome
gem 'font-awesome-sass'

# Replace sprockets as asset pipeline
gem 'propshaft'

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem 'debug', platforms: %i[mri mingw x64_mingw]
end

# Simple Form for store (TODO: Get rid of in store)
gem 'simple_form'

group :development do
  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem 'web-console'

  # Use sqlite3 as the database for Active Record
  gem 'sqlite3', '~> 1.4'

  # Add speed badges [https://github.com/MiniProfiler/rack-mini-profiler]
  # gem "rack-mini-profiler"

  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem "spring"

  # Static Code Analysis (linting & vulnerability detection)
  gem 'brakeman'
  gem 'erb_lint'
  gem 'prettier_print' # @prettier/plugin-ruby dep
  gem 'rubocop-capybara'
  gem 'rubocop-rails'
  gem 'syntax_tree' # @prettier/plugin-ruby dep
  gem 'syntax_tree-rbs' # @prettier/plugin-ruby dep
  gem 'syntax_tree-haml' # @prettier/plugin-ruby dep
end

group :test do
  # Use system testing [https://guides.rubyonrails.org/testing.html#system-testing]
  gem 'capybara'
  gem 'selenium-webdriver'
  gem 'webdrivers'
end

group :production do
  gem 'mysql2'
end
