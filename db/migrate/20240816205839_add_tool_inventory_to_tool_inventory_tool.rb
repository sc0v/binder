class AddToolInventoryToToolInventoryTool < ActiveRecord::Migration[7.0]
  def change
    add_reference :tool_inventory_tools, :tool_inventory, null: false, foreign_key: true
  end
end
