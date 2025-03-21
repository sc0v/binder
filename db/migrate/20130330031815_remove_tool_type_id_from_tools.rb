# frozen_string_literal: true
class RemoveToolTypeIdFromTools < ActiveRecord::Migration[6.0]
  def up
    remove_column :tools, :tool_type_id
  end

  def down
    add_column :tools, :tool_type_id, :string
  end
end
