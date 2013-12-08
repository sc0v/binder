require 'test_helper'

class MembershipTest < ActiveSupport::TestCase
  # Relationships
  should belong_to(:organization)
  should belong_to(:participant)
  #should have_many(:checkouts)
  #should have_many(:tools).through(:checkouts)
  

  # Validations
  should validate_presence_of(:participant_id)
  should validate_presence_of(:organization_id)

  context "With a proper context, " do
    setup do
      create_context
    end

    teardown do
      remove_context
    end

    should "show that all factories are properly created" do
      assert_equal 3, Membership.all.size
    end
  
    # Scopes
    
    # Methods
    context "Testing memberships" do
      should "know booth chairs" do
        #puts Membership.booth_chairs.map{ |bc| bc.participant.andrewid }
        assert_equal 1, Membership.booth_chairs.size
        assert_equal ["asteger_FG"], Membership.booth_chairs.map{|e| e.participant.andrewid}
      end  
    end
  end
end
