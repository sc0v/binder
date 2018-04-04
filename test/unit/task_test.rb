# ## Schema Information
#
# Table name: `tasks`
#
# ### Columns
#
# Name                   | Type               | Attributes
# ---------------------- | ------------------ | ---------------------------
# **`completed_by_id`**  | `integer`          |
# **`created_at`**       | `datetime`         |
# **`description`**      | `text(65535)`      |
# **`due_at`**           | `datetime`         |
# **`id`**               | `integer`          | `not null, primary key`
# **`is_completed`**     | `boolean`          |
# **`name`**             | `string(255)`      |
# **`updated_at`**       | `datetime`         |
#

require 'test_helper'

class TaskTest < ActiveSupport::TestCase
  # Relationships
  should belong_to(:completed_by) #need something about Participants here? See model...

  # Validations
  should validate_presence_of(:name)
  should validate_presence_of(:due_at)

  context "With a proper context, " do
    setup do
      # Create 3 tasks
      @assign_rides = FactoryGirl.create(:task, :due_at => Time.now - 2.hour)
      @buy_wood = FactoryGirl.create(:task, :due_at => Time.now + 5.hour)
      @takeout_trash = FactoryGirl.create(:task, :is_completed => true, :due_at => Time.now + 1.hour)
    end

    teardown do
    end

    should "show that all factories are properly created" do
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
    should "show that the is_past_due method works" do
      assert_equal true, @assign_rides.is_past_due
      assert_equal false, @buy_wood.is_past_due
      assert_equal false, @takeout_trash.is_past_due
    end
  end
end

