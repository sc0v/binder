class ShiftParticipant < ActiveRecord::Base
  belongs_to :shift
  belongs_to :participant
  attr_accessible :clocked_in_at, :clocked_out_at, :shift, :participant
  validates :shift_id, :presence => true

  scope :current, :where(:clocked_in_at != nil, :clocked_out_at => nil)
end
