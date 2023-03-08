# frozen_string_literal: true

class ToolTypeCertification < ApplicationRecord
  belongs_to :tool_type
  belongs_to :certification_type
  scope :active,       -> { where(active: true) }
  scope :inactive,     -> { where(active: false) }
end
