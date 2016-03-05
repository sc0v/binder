class AddToolTypesRemoveToolName < ActiveRecord::Migration
  def change
    add_reference :tools, :tool_type, index: true, foreign_key: true
    remove_column :tools, :name, :string
  end
end
