require 'test_helper'

class ParticipantTest < ActiveSupport::TestCase
  # Relationships
  should have_many(:organizations).through(:memberships)
  should have_many(:shifts).through(:shift_participants)
  should have_many(:organizations).through(:memberships)
  should have_many(:checkouts)
  should have_many(:tools).through(:checkouts)
  should have_many(:memberships)
  should have_many(:shift_participants)
  should belong_to(:user)

  # Validations

  context "With a proper context, " do
    setup do
      create_context
    end

    teardown do
      remove_context
    end

    should "show that all factories are properly created" do
      assert_equal 6, Participant.all.size
    end

    context "Testing participants" do
      should "know participants" do
        assert_equal ["asteger_FG", "dcorwin_FG", "juc", "member_FG", "rcrown_FG", "shannon1_FG"], Participant.all.map{|e| e.andrewid}
      end

      should "correctly format a participant's phone number" do
        assert_equal "(123) 456-7890", @member_participant.formatted_phone_number

        @temp_participant = FactoryGirl.build(:participant, :phone_number => nil)
        assert_equal "N/A", @temp_participant.formatted_phone_number
      end
    end
    
  end
end
