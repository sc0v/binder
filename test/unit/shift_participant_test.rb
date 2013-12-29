require 'test_helper'

class ShiftParticipantTest < ActiveSupport::TestCase
  # Relationships
  should belong_to(:shift)
  should belong_to(:participant)

  # Validations
  should validate_presence_of(:shift)
  should validate_presence_of(:clocked_in_at)
  should validate_presence_of(:participant)

  context "With a proper context, " do
    setup do
      FactoryGirl.create(:shift_participant)
    end

    teardown do
    end

    should "show that all factories are properly created" do
      assert_equal 1, ShiftParticipant.all.size
    end
 
    # Scopes
    
    # Methods

  end
end
