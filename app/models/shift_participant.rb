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

  scope :current, -> { where('clocked_out_at <> NULL') }
end

