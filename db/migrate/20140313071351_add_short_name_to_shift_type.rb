# frozen_string_literal: true
class AddShortNameToShiftType < ActiveRecord::Migration[6.0]
  def change
    add_column :shift_types, :short_name, :string
  end
end
