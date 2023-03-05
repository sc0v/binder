class ShiftParticipant < ActiveRecord::Base
  validates_presence_of :shift_id, :participant_id
  validates_associated :shift, :participant

  belongs_to :shift, :touch => true
  belongs_to :participant, :touch => true

  scope :checked_in_late, lambda{ joins(:shift).where('starts_at < ? AND clocked_in_at > starts_at', Time.zone.now)}
  scope :active,       -> { where(active: true) }
  scope :inactive,     -> { where(active: false) }

  # For lookups
  def card_number=( card_number )
    @card_number = card_number
  end

  def card_number
    @card_number
  end

end
