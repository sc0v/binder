# frozen_string_literal: true

class ToolInventory < ApplicationRecord
  has_many :tool_inventory_tools

  validate :ensure_one, on: %i[create save]

  def ensure_one
    return unless ToolInventory.count >= 1

    errors.add(:base, 'Only one Tool Inventory can exist at a time')
  end
end
