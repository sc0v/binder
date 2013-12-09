require 'test_helper'

class CarnegieMellonPersonTest < ActiveSupport::TestCase
  # Relationships

  # Validations

  # Scopes

  # Methods

  setup do
  end

  teardown do
  end

  should "correctly pull student information given andrew id" do
  	assert_equal "Senior", CarnegieMellonPerson.find_by_andrewid('juc').cmuStudentClass
	end
end

