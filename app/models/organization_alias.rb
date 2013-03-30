class OrganizationAlias < ActiveRecord::Base
  belongs_to :organization
  attr_accessible :alias
  validates :alias, :uniqueness => true, :presence => true
  validates :organization_id, :presence => true
  validates_associated :organization
end
