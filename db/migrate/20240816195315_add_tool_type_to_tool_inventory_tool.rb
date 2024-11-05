class AddToolTypeToToolInventoryTool < ActiveRecord::Migration[7.0]
  def change
    add_reference :tool_inventory_tools, :tool_type, null: false, foreign_key: true
  end
end