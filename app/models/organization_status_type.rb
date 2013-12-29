class OrganizationStatusType < ActiveRecord::Base
  validates :name, :presence => true, :uniqueness => true

  has_many :organization_statuses, dependent: :destroy
  has_many :organizations, :through => :organization_statues
end
