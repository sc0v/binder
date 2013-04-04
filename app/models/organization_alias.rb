class OrganizationAlias < ActiveRecord::Base
  belongs_to :organization
  attr_accessible :name, :organization
  validates :name, :uniqueness => true, :presence => true
  validates :organization_id, :presence => true
  validates_associated :organization
end
