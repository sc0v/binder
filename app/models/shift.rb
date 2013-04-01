class Shift < ActiveRecord::Base
  belongs_to :organization
  attr_accessible :ends_at, :starts_at, :required_number_of_participants, :organization, :shift_type
  has_many :participants, :through => :shift_participants
  has_many :shift_participants
  belongs_to :shift_type
  validates :organization_id, :starts_at, :ends_at, :required_number_of_participants, :presence => true

  scope :current, lambda { where("starts_at < ? and ends_at < ?", Time.zone.now, Time.zone.now ) }
  scope :upcomming, lambda { where("starts_at < ?", Time.zone.now + 2.hours ) unless where("starts_at < ?", Time.zone.now ) }
end
