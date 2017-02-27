# ## Schema Information
#
# Table name: `shift_participants`
#
# ### Columns
#
# Name                  | Type               | Attributes
# --------------------- | ------------------ | ---------------------------
# **`clocked_in_at`**   | `datetime`         |
# **`created_at`**      | `datetime`         |
# **`id`**              | `integer`          | `not null, primary key`
# **`participant_id`**  | `integer`          |
# **`shift_id`**        | `integer`          |
# **`updated_at`**      | `datetime`         |
#
# ### Indexes
#
# * `index_shift_participants_on_participant_id`:
#     * **`participant_id`**
# * `index_shift_participants_on_shift_id`:
#     * **`shift_id`**
#

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
      @shift = FactoryGirl.create(:shift, :ends_at => Time.zone.now + 2.hour, :starts_at => Time.zone.now)
      @late= FactoryGirl.create(:shift_participant, :shift_id => @shift.id, :clocked_in_at => Time.zone.now + 1.hour)
      @not_late= FactoryGirl.create(:shift_participant, :shift_id => @shift.id, :clocked_in_at => Time.zone.now)
    end

    teardown do
    end

    should "show that all factories are properly created" do
      assert_equal 2, ShiftParticipant.all.size
    end

    # Scopes
    should "show that scope 'checked in late' is working" do
      assert_equal @late.id , ShiftParticipant.checked_in_late[0].id
    end

    # Methods

  end
end






