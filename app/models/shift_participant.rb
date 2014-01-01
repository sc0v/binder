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

class ShiftParticipant < ActiveRecord::Base
  validates_presence_of :shift, :clocked_in_at, :participant
  validates_associated :shift, :participant

  belongs_to :shift
  belongs_to :participant

  # For lookups
  def card_number=( card_number )
    @card_number = card_number
  end

  def card_number
    @card_number
  end
end

