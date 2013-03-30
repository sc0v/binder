class Shift < ActiveRecord::Base
  belongs_to :organization
  attr_accessible :ends_at, :starts_at, :required_number_of_participants, :organization, :shift_type
  has_many :participants, :through => :shift_participants
  has_many :shift_participants
  belongs_to :shift_type
  validates :organization_id, :starts_at, :ends_at, :presence => true
end
