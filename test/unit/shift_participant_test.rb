# frozen_string_literal: true
require 'test_helper'

class ShiftParticipantTest < ActiveSupport::TestCase
  # Relationships
  should belong_to(:shift)
  should belong_to(:participant)

  # Validations
  should validate_presence_of(:shift_id)
  should validate_presence_of(:participant_id)

  context 'With a proper context, ' do
    setup do
      @shift = FactoryGirl.create(:shift, ends_at: 2.hours.from_now, starts_at: Time.zone.now)
      @late = FactoryGirl.create(:shift_participant, shift_id: @shift.id, clocked_in_at: 1.hour.from_now)
      @not_late = FactoryGirl.create(:shift_participant, shift_id: @shift.id, clocked_in_at: Time.zone.now)
    end

    teardown do
    end

    should 'show that all factories are properly created' do
      assert_equal 2, ShiftParticipant.all.size
    end

    # Scopes
    should "show that scope 'checked in late' is working" do
      assert_equal @late.id, ShiftParticipant.checked_in_late[0].id
    end

    # Methods
  end
end
