# frozen_string_literal: true

class ToolType < ApplicationRecord
  has_many :tools
  has_many :tool_inventory_tools
  has_many :certs, through: :tool_type_certifications, source: :tool_type
  has_many :tool_type_certifications, dependent: :destroy
  validates :name, presence: true, uniqueness: true

  default_scope { order(:name) }
  scope :active,       -> { where(active: true) }
  scope :inactive,     -> { where(active: false) }
end
