class RemoveToolTypeIdFromTools < ActiveRecord::Migration
  def up
    remove_column :tools, :tool_type_id
  end

  def down
    add_column :tools, :tool_type_id, :string
  end
end
