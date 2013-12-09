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
      @participant = FactoryGirl.create(:participant, :phone_number => 1234567890)
      @temp_participant = FactoryGirl.create(:participant)
    end

    teardown do
    end

    should "show that all factories are properly created" do
      assert_equal 2, Participant.all.size
    end

    context "Testing participants" do
      should "correctly format a participant's phone number" do
        assert_equal "(123) 456-7890", @participant.formatted_phone_number

        assert_equal "N/A", @temp_participant.formatted_phone_number
      end
    end
    
  end
end
