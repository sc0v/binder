class OrganizationAlias < ActiveRecord::Base
  attr_accessible :name, :organization, :organization_id

  validates :name, :uniqueness => true, :presence => true
  validates :organization_id, :presence => true
  validates_associated :organization

  belongs_to :organization  
  
  scope :search, lambda { |term| where('lower(name) LIKE lower(?)', "#{term}%") }

end
