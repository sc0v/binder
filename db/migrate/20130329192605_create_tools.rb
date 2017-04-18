class CreateTools < ActiveRecord::Migration
  def change
    create_table :tools do |t|
      t.string :name, :null => false
      t.integer :barcode
      t.text :description

      t.references :tool_type, :null => false

      t.timestamps
    end

    add_index :tools, :barcode, unique: true
  end
end
