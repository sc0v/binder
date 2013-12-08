class ShiftParticipant < ActiveRecord::Base
  belongs_to :shift
  belongs_to :participant

  # attr_accessible :clocked_in_at, :clocked_out_at, :shift, :participant

  # For lookups
  def card_number=( card_number )
    @card_number = card_number
  end

  def card_number
    @card_number
  end

  validates_presence_of :shift, :clocked_in_at, :participant
  validates_associated :shift, :participant

  scope :current, -> { where('clocked_out_at <> NULL') }

end
