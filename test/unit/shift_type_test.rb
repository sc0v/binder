require 'test_helper'

class ShiftTypeTest < ActiveSupport::TestCase
  # Relationships
  should have_many(:shifts)

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
      assert_equal 3, ShiftType.all.size
    end
 
    # Scopes

    # Methods

    #use factory girl to test uniqueness of name and dependent destroy

  end
end