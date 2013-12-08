require 'test_helper'

class ShiftParticipantTest < ActiveSupport::TestCase
  # Relationships
  should belong_to(:shift)
  should belong_to(:participant)

  # Validations
  should validate_presence_of(:shift_id)
  should validate_presence_of(:clocked_in_at)
  should validate_presence_of(:participant_id)

  context "With a proper context, " do
    setup do
      create_context
    end

    teardown do
      remove_context
    end

    should "show that all factories are properly created" do
      assert_equal 4, ShiftParticipant.all.size
    end
 
    # Scopes
    should "have a scope 'current' that works" do
       assert_equal 0, ShiftParticipant.current.size
    end
    
    # Methods

  end
end
