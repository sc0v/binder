# frozen_string_literal: true

class ToolType < ApplicationRecord
  belongs_to :tool_waitlists
  has_many :waitlist_entries
  has_many :tools
  has_many :certs, through: :tool_type_certifications, source: :tool_type
  has_many :tool_type_certifications, dependent: :destroy
  validates :name, presence: true, uniqueness: true

  default_scope { order(:name) }
  scope :active,       -> { where(active: true) }
  scope :inactive,     -> { where(active: false) }
end
