# frozen_string_literal: true

begin
  require 'coveralls'
  Coveralls.wear!('rails')
rescue LoadError
  # Coveralls is optional in local/dev containers.
end

begin
  require 'webmock/minitest'
rescue LoadError
  # WebMock is optional in local/dev containers.
end

ENV['RAILS_ENV'] = 'test'
require File.expand_path('../config/environment', __dir__)
require 'rails/test_help'
require 'factory_bot'
require 'shoulda/context'
require 'shoulda/matchers'

FactoryBot.find_definitions

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :minitest
    with.library :rails
  end
end

ActiveRecord::Migration.maintain_test_schema!

class ActiveSupport::TestCase
  include WebMock::API if defined?(WebMock)

  def deny(condition)
    assert_not condition
  end

  def create_context
  end

  def remove_context
  end
end

class ActionDispatch::IntegrationTest
  # Sign in as a test account through the developer sign-in page
  def sign_in_as(participant)
    post dev_login_as_path(participant)
  end
end

# Load Action Cable's test settings now, before any test runs as another
# environment, which would otherwise load that environment's
ActionCable.server.config

# Draw the routes now, as the test environment. Rails draws them on the first
# request; if that comes inside with_rails_env('production'), the developer
# sign-in routes are left out for the rest of the run.
Rails.application.reload_routes_unless_loaded

# Run a block as if Rails were in another environment, such as staging
def with_rails_env(name)
  original = Rails.env
  Rails.env = name
  yield
ensure
  Rails.env = original
end
