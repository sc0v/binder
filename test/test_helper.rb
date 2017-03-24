require 'coveralls'
Coveralls.wear!('rails')

require 'webmock/minitest'
include WebMock::API

ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

ActiveRecord::Migration.maintain_test_schema!

class ActiveSupport::TestCase

  def deny(condition)
    assert !condition
  end

  def create_context
  end

  def remove_context
  end
end
