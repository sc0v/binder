# frozen_string_literal: true
class AddToolTypesRemoveToolName < ActiveRecord::Migration[6.0]
  def change
    add_reference :tools, :tool_type, index: true, foreign_key: true
    remove_column :tools, :name, :string
  end
end
