require 'test_helper'

class CarnegieMellonPersonTest < ActiveSupport::TestCase
  # Relationships

  # Validations

  # Scopes

  # Methods

  # why did I put these here? Are these necessary? I don't think so,
  # given the assertions below are self-contained
  setup do
    create_context
  end

  teardown do
    #remove_context
  end

  should "correctly pull student information given andrew id" do
  	assert_equal "Senior", CarnegieMellonPerson.find_by_andrewid('juc').cmuStudentClass
	end

end