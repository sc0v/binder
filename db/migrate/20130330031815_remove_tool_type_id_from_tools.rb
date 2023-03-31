# frozen_string_literal: true
class RemoveToolTypeIdFromTools < ActiveRecord::Migration[4.2]
  def up
    remove_column :tools, :tool_type_id
  end

  def down
    add_column :tools, :tool_type_id, :string
  end
end
