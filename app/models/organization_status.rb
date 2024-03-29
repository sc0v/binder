# frozen_string_literal: true

class OrganizationStatus < ApplicationRecord
  validates_associated :organization_status_type, :organization, :participant

  belongs_to :organization_status_type
  belongs_to :organization, touch: true
  belongs_to :participant

  scope :displayable, -> { joins(:organization_status_type).where(organization_status_types: { display: true }) }
  scope :active,       -> { where(active: true) }
  scope :inactive,     -> { where(active: false) }
end
