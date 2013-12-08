require 'test_helper'

class ChargeTypeTest < ActiveSupport::TestCase
  # Relationships
  should have_many(:charges)

  # Validations


  context "With a proper context, " do
    setup do
      create_context
    end

    teardown do
      remove_context
    end

    should "show that all factories are properly created" do
      assert_equal 2, ChargeType.all.size
    end

    # Scopes
  
    # Methods
  end
end