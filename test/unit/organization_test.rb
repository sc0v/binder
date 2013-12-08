require 'test_helper'

class OrganizationTest < ActiveSupport::TestCase
  # Relationships
  should belong_to(:organization_category)
  should have_many(:memberships)
  should have_many(:organization_aliases)
  should have_many(:participants).through(:memberships)
  should have_many(:charges)
  should have_many(:tools).through(:checkouts)
  should have_many(:checkouts)
  should have_many(:shifts)


  #  Test for dependent destroy later
  # test "should delete its childs when it is destroyed" do

  #   domain = Domain.new(:name => "test.com")
  #   domain.save!

  #   account = Account.new(:email => "blabla" , :domain => domain , :password => "password")
  #   account.save!

  #   alias_first_child = Alias.new(:source => "first_child" , :source_domain_id => domain , :destination => account, :active => true)
  #   alias_first_child.save!

  #   assert_not_nil(Account.find_by_email("blabla"))
  #   assert_not_nil(Alias.find_by_source("first_child"))

  #   # destroy the account
  #   account.destroy

  #   assert_nil(Account.find_by_email("blabla"))
  #   assert account.aliases.count == 0
  #   assert_nil(Alias.find_by_source("first_child") , "first child should not be found in Alias Table")

  # end


  # Validations



  context "With a proper context, " do
    setup do
      create_context
    end

    teardown do
      remove_context
    end

    should "show that all factories are properly created" do
      assert_equal 3, Organization.all.size
    end

    # Scopes
  
    # Methods

  end
end