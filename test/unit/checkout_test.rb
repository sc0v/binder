require 'test_helper'

class CheckoutTest < ActiveSupport::TestCase
  # Relationships
  should belong_to(:participant)
  should belong_to(:organization)
  should belong_to(:tool)
  
  # Validations
  should validate_presence_of(:tool)

  context "With a proper context, " do
    setup do
      create_context
    end

    teardown do
      remove_context
    end

    should "show that all factories are properly created" do
      assert_equal 4, Checkout.all.size
    end

    # Scopes
  
    # Methods

    should "show that a checkout has participant or organization" do
      assert_equal true, @hammer_checkout2.hasParticipantOrOrganization
      assert_equal true, @saw_checkout.hasParticipantOrOrganization
      assert_equal true, @hard_hat_checkout.hasParticipantOrOrganization
    end

  end
end
