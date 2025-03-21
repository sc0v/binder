# frozen_string_literal: true
class CreateToolTypes < ActiveRecord::Migration[6.0]
  def change
    create_table :tool_types do |t|
      t.string :name
      t.timestamps
    end
  end
end
