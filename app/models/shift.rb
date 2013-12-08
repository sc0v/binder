class Shift < ActiveRecord::Base
  before_save :set_end_time
  belongs_to :organization

  attr_accessible :ends_at, :starts_at, :required_number_of_participants, :organization, :shift_type

  has_many :participants, :through => :shift_participants
  has_many :shift_participants
  belongs_to :shift_type

  #business logic: should be able to create shift without org.
  validates :starts_at, :ends_at, :required_number_of_participants, :presence => true
  validates :starts_at, :ends_at, :required_number_of_participants, :presence => true

  scope :current, lambda { where("starts_at < ? and ends_at > ?", Time.zone.now, Time.zone.now ) }
  scope :upcoming, lambda { where("starts_at > ? and starts_at < ?", Time.zone.now, Time.zone.now + 2.hours ) }
  #scopes for each type of shift, selected by their shift_type ID
  scope :watch_shifts, where('shift_type_id = ?', 1)
  scope :sec_shifts, where('shift_type_id = ?', 2)
  scope :coord_shifts, where('shift_type_id = ?', 3)
  
  private
  def set_end_time
    et = self.ends_at
    self.ends_at = starts_at + 2.hours if et.nil? || et.blank?
  end

end
