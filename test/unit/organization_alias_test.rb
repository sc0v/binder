require 'test_helper'

class OrganizationAliasTest < ActiveSupport::TestCase
  # Relationships
  should belong_to(:organization)

  # Validations


  context "With a proper context, " do
    setup do
      create_context
    end

    teardown do
      remove_context
    end

    should "show that all factories are properly created" do
      assert_equal 3, OrganizationAlias.all.size
    end
    
    # Scopes
  
    # Methods


  end
end