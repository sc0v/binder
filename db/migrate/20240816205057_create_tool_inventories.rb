# frozen_string_literal: true

class CreateToolInventories < ActiveRecord::Migration[7.0]
  def change
    create_table :tool_inventories, &:timestamps
  end
end
