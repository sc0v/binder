class OrganizationStatus < ActiveRecord::Base
  validates :description, :presence => true
  validates_presence_of :organization_status_type, :organization, :participant
  validates_associated :organization_status_type, :organization, :participant

  belongs_to :organization_status
  belongs_to :organization
  belongs_to :participant
end
