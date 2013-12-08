require 'test_helper'

class ShiftTest < ActiveSupport::TestCase
  # Relationships
  should belong_to(:organization)
  should have_many(:participants).through(:shift_participants)
  should have_many(:shift_participants)
  should belong_to(:shift_type)

  # Validations
  #does not need to have an organization
  should validate_presence_of(:starts_at)
  should validate_presence_of(:ends_at)
  should validate_presence_of(:required_number_of_participants)
 
  context "With a proper context, " do
    setup do
      create_context
    end

    teardown do
      remove_context
    end

    should "show that all factories are properly created" do
      assert_equal 3, Shift.all.size
    end

    # Scopes
    should "have a scope 'current' that works" do
       assert_equal 0, Shift.current.size
    end
    

    should "have a scope 'upcoming' that works" do
       assert_equal 0, Shift.upcoming.size
    end
    

    # Methods

  end
end
