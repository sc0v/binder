# frozen_string_literal: true

class OrganizationAlias < ApplicationRecord
  validates :name, presence: true
  validates_associated :organization
  validates :name, uniqueness: true

  belongs_to :organization

  scope :search, ->(term) { where('lower(name) LIKE lower(?)', "#{term}%") }
  scope :active,       -> { where(active: true) }
  scope :inactive,     -> { where(active: false) }

  def formatted_name
    "#{organization.name} (#{name})"
  end
end
