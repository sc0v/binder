class Membership < ActiveRecord::Base
  belongs_to :organization
  belongs_to :participant
  attr_accessible :is_booth_chair, :title, :organization, :participant, :booth_chair_order
  validates :participant_id, :organization_id, :presence => true
  validates_uniqueness_of :participant_id, :scope => :organization_id
  has_many :tools, :through => :checkouts
  has_many :checkouts

  default_scope order('booth_chair_order ASC')
  scope :booth_chairs, where(:is_booth_chair => true)
  
end
