class Membership < ActiveRecord::Base
  belongs_to :organization
  belongs_to :participant
  attr_accessible :is_booth_chair, :title, :organization, :participant
  validates :participant_id, :organization_id, :presence => true
  has_many :tools, :through => :checkouts
  has_many :checkouts

  scope :booth_chairs, where(:is_booth_chair => true)
end
