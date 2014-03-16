class AddShortNameToShiftType < ActiveRecord::Migration
  def change
    add_column :shift_types, :short_name, :string
  end
end
