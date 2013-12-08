class Organization < ActiveRecord::Base
  attr_accessible :name, :organization_category_id, :organization_category, :memberships, :organization_aliases, :charges, :tools, :checkouts, :shifts

  belongs_to :organization_category
  has_many :memberships
  has_many :organization_aliases, :dependent => :destroy
  has_many :participants, :through => :memberships
  has_many :charges, :dependent => :destroy
  has_many :tools, :through => :checkouts
  has_many :checkouts
  has_many :shifts, :dependent => :destroy
  
  validates :organization_category, :presence => true
  validates :name, :presence => true, :uniqueness => true

  default_scope order('name asc')
  scope :alphabetical, order('name')

  scope :search, lambda { |term| where('lower(name) LIKE lower(?)', "#{term}%") }

  
end
