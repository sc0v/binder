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
