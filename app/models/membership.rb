class Membership < ActiveRecord::Base
  # attr_accessible :is_booth_chair, :title, :organization, :participant, :booth_chair_order, :role_ids

  attr_accessor :role_ids

  validates :participant_id, :organization_id, :presence => true
  validates_uniqueness_of :participant_id, :scope => :organization_id

  belongs_to :organization
  belongs_to :participant
  #has_many :checkouts
  has_many :tools, :through => :checkouts

  default_scope { order('booth_chair_order ASC') }
  scope :booth_chairs, -> { where(:is_booth_chair => true) }
  
end
