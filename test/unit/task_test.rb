require 'test_helper'

class TaskTest < ActiveSupport::TestCase
  # Relationships
  should belong_to(:completed_by) #need something about Participants here? See model...

  # Validations
  should validate_presence_of(:name)
  should validate_presence_of(:due_at)

  context "With a proper context, " do
    setup do
      create_context
    end

    teardown do
      remove_context
    end

    should "show that all factories are properly created" do
      assert_equal 3, Task.all.size
    end
   
    # Scopes
    should "have a scope 'upcoming' that works" do
       assert_equal 0, Task.upcoming.size
    end

    # Methods
    should "show that the is_past_due method works" do
      assert_equal true, @assign_rides.is_past_due
      assert_equal true, @buy_wood.is_past_due
      assert_equal false, @takeout_trash.is_past_due
    end
  end
end

