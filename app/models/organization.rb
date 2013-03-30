class Organization < ActiveRecord::Base
  belongs_to :organization_category
  attr_accessible :name
  has_many :memberships
  has_many :organization_aliases, :dependent => :destroy
  has_many :participants, :through => :memberships
  has_many :charges, :dependent => :destroy
  has_many :tools, :through => :memberships
  has_many :shifts, :dependent => :destroy
  validates :organizaion_category, :presence => true
  validates :name, :presence => true, :uniqueness => true
end
