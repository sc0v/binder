# frozen_string_literal: true
require 'coveralls'
Coveralls.wear!('rails')

require 'webmock/minitest'
include WebMock::API

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
