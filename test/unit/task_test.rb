# frozen_string_literal: true

require 'test_helper'

class TaskTest < ActiveSupport::TestCase
  # Relationships
  should belong_to(:completed_by) # need something about Participants here? See model...

  # Validations
  should validate_presence_of(:name)
  should validate_presence_of(:due_at)

  context 'With a proper context, ' do
    setup do
      # Create 3 tasks
      @assign_rides = FactoryGirl.create(:task, due_at: 2.hours.ago)
      @buy_wood = FactoryGirl.create(:task, due_at: 5.hours.from_now)
      @takeout_trash = FactoryGirl.create(:task, is_completed: true, due_at: 1.hour.from_now)
    end

    teardown do
    end

    should 'show that all factories are properly created' do
      assert_equal 3, Task.all.size
    end

    # Scopes
    should "have a scope 'upcoming' that works" do
      assert_equal 2, Task.upcoming.size
    end

    should "have a scope 'is_incomplete' that works" do
      assert_equal 2, Task.is_incomplete.size
    end

    should "have a scope 'is_complete' that works" do
      assert_equal 1, Task.is_complete.size
    end
    # Methods
    should 'show that the is_past_due method works' do
      assert_equal true, @assign_rides.is_past_due
      assert_equal false, @buy_wood.is_past_due
      assert_equal false, @takeout_trash.is_past_due
    end
  end
end
