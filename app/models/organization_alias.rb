class OrganizationAlias < ActiveRecord::Base
  validates_presence_of :name, :organization
  validates_associated :organization
  validates :name, :uniqueness => true

  belongs_to :organization  
  
  scope :search, lambda { |term| where('lower(name) LIKE lower(?)', "#{term}%") }
end

