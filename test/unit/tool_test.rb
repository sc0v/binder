require 'test_helper'

class ToolTest < ActiveSupport::TestCase
  # Relationships
  should have_many(:checkouts)
  should have_many(:participants).through(:checkouts)
  should have_many(:organizations).through(:checkouts)

  # Validations
  # should validate_uniqueness_of(:barcode)
  # should validate_uniqueness_of(:name)

  context "With a proper context, " do
    setup do
      create_context
    end

    teardown do
      remove_context
    end

    should "show that all factories are properly created" do
      assert_equal 5, Tool.all.size
    end

    should "have a scope 'hardhats' that works" do
       assert_equal 1, Tool.hardhats.size
    end


    should "have a scope 'radios' that works" do
       assert_equal 1, Tool.radios.size
    end


    should "have a scope 'just_tools' that works" do
       assert_equal 3, Tool.just_tools.size
    end

    should "show that the 'current_participant' method works" do
      assert_equal nil, @hammer.current_participant
      assert_equal @shannon_participant, @saw.current_participant
      assert_equal nil, @hard_hat.current_participant
      assert_equal nil, @ladder.current_participant
    end

    should "show that the 'current_organization' method works" do
      assert_equal @sdc, @hammer.current_organization
      assert_equal @theta, @saw.current_organization
      assert_equal @theta, @hard_hat.current_organization
      assert_equal nil, @ladder.current_organization
    end
 
    should "show that the is_checked_out? method works" do
      assert @hammer.is_checked_out?
      assert @saw.is_checked_out?
      assert @hard_hat.is_checked_out?
      deny @ladder.is_checked_out?
    end

    should "show that the 'self.checked_out_by_organization(organization)' method works" do
      assert_equal [@saw, @hard_hat], Tool.checked_out_by_organization(@theta)
    end

    
  end
end
