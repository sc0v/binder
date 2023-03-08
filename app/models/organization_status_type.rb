# frozen_string_literal: true

class OrganizationStatusType < ApplicationRecord
  validates :name, presence: true, uniqueness: true

  has_many :organization_statuses, dependent: :destroy
  scope :active,       -> { where(active: true) }
  scope :inactive,     -> { where(active: false) }
end
