class Membership < ActiveRecord::Base
  belongs_to :organization
  belongs_to :participant
  attr_accessible :is_booth_chair, :title
  has_many :tools, :through => :checkouts
  has_many :checkouts
end
