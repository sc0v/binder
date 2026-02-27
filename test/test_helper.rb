# frozen_string_literal: true
begin
  require 'coveralls'
  Coveralls.wear!('rails')
rescue LoadError
  # Coveralls is optional in local/dev containers.
end

begin
  require 'webmock/minitest'
  include WebMock::API
rescue LoadError
  # WebMock is optional in local/dev containers.
end

ENV['RAILS_ENV'] = 'test'
require File.expand_path('../config/environment', __dir__)
require 'rails/test_help'

ActiveRecord::Migration.maintain_test_schema!

class ActiveSupport::TestCase
  def deny(condition)
    assert_not condition
  end

  def create_context; end

  def remove_context; end
end

class ActionDispatch::IntegrationTest
  private

  # Signs in by hitting the impersonate endpoint, which sets the real encrypted
  # session cookie via ActionDispatch (same code path as SAML login).
  # CSRF protection is disabled in the test environment via allow_forgery_protection = false.
  def sign_in_as(participant)
    post "/impersonate/#{participant.id}"
  end
end
