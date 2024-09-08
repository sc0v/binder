class CreateToolInventoryTools < ActiveRecord::Migration[7.0]
  def change
    create_table :tool_inventory_tools do |t|
      t.integer :barcode
      t.string :description
      t.boolean :active

      t.timestamps
    end
    add_index :tool_inventory_tools, :barcode, unique: true
  end
end
