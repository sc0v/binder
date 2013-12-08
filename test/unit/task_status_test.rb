require 'test_helper'

class TaskStatusTest < ActiveSupport::TestCase
  # Relationships
  should have_many(:tasks)

  # Validations
  should validate_presence_of(:name)

  context "With a proper context, " do
    setup do
      create_context
    end

    teardown do
      remove_context
    end

    should "show that all factories are properly created" do
      assert_equal 3, TaskStatus.all.size
    end
   
    # Scopes

    # Methods

  end
end