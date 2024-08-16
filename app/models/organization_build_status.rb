class OrganizationBuildStatus < ApplicationRecord
  belongs_to :organization

  has_many :organization_build_steps
end
