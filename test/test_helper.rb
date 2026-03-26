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
  def sign_in_as(participant)
    cookies.encrypted[:user_id] = participant.id
  end
end
