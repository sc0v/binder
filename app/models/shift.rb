class Shift < ActiveRecord::Base
  validates_presence_of :starts_at, :ends_at, :required_number_of_participants, :shift_type
  validates_associated :organization, :shift_type
  
  belongs_to :organization
  belongs_to :shift_type

  has_many :participants, :through => :shift_participants
  has_many :shift_participants, :dependent => :destroy

  scope :current, lambda { where("starts_at < ? and ends_at > ?", Time.zone.now, Time.zone.now ) }
  scope :upcoming, lambda { where("starts_at > ? and starts_at < ?", Time.zone.now, Time.zone.now + 1.hours ) }

  #scopes for each type of shift, selected by their shift_type ID
  scope :watch_shifts, -> { where('shift_type_id = ?', 1) }
  scope :sec_shifts, -> { where('shift_type_id = ?', 2) }
  scope :coord_shifts, -> { where('shift_type_id = ?', 3) }
end

