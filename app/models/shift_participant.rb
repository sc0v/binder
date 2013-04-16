class ShiftParticipant < ActiveRecord::Base
  belongs_to :shift
  belongs_to :participant
  attr_accessible :clocked_in_at, :clocked_out_at, :shift, :participant, :shift_id, :participant_id
  validates :shift_id, :clocked_in_at, :participant_id, :presence => true

  scope :current, where('clocked_out_at <> NULL')
end
