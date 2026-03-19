# frozen_string_literal: true

class AddActiveToTools < ActiveRecord::Migration[7.0]
  def change
    add_column :tools, :active, :boolean, null: false, default: true
  end
end
