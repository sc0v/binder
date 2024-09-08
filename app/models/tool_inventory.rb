class ToolInventory < ApplicationRecord
  has_many :tool_inventory_tools

  validate :ensure_one, on: [:create, :save]

  def ensure_one
    if ToolInventory.all.count >= 1
      errors.add(:base, 'Only one Tool Inventory can exist at a time')
    end
  end
end
