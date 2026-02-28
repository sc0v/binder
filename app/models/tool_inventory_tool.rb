# frozen_string_literal: true

class ToolInventoryTool < ApplicationRecord
  belongs_to :tool_inventory
  belongs_to :tool_type

  validates :barcode,
            presence: true,
            uniqueness: true,
            length: {
              minimum: 1,
              maximum: 5
            }

  delegate :name, to: :tool_type, allow_nil: true

  # Returns true if two tools have the same barcode and toolType
  def equal_to_tool(tool)
    barcodeEquality = (barcode == tool.barcode)
    toolTypeEquality = (name == tool.name)
    barcodeEquality && toolTypeEquality
  end
end
