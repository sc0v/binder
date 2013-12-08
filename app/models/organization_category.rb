class OrganizationCategory < ActiveRecord::Base
  # attr_accessible :name

  validates :name, :presence => true, :uniqueness => true

  has_many :organizations
  
end
