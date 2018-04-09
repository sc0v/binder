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
  validates_presence_of :shift_id, :participant_id
  validates_associated :shift, :participant

  belongs_to :shift, :touch => true
  belongs_to :participant, :touch => true

  scope :checked_in_late, lambda{ joins(:shift).where('starts_at < ? AND clocked_in_at > starts_at', Time.zone.now)}

  # For lookups
  def card_number=( card_number )
    @card_number = card_number
  end

  def card_number
    @card_number
  end

end