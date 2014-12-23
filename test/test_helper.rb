#require 'simplecov'
#SimpleCov.start do
#  add_group "Models", "app/models"
#  add_group "Controllers", "app/controllers"
#  add_group "Views", "app/views"
#end

#require 'simplecov-rcov'
#class SimpleCov::Formatter::MergedFormatter
#  def format(result)
#    SimpleCov::Formatter::HTMLFormatter.new.format(result)
#    SimpleCov::Formatter::RcovFormatter.new.format(result)
#  end
#end
#SimpleCov.formatter = SimpleCov::Formatter::MergedFormatter

require 'webmock/minitest'
include WebMock::API


ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase

  def deny(condition)
    assert !condition
  end

  def create_context
  end

  def remove_context
  end
end
