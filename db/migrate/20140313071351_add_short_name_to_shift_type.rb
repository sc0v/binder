class AddShortNameToShiftType < ActiveRecord::Migration[4.2]
  def change
    add_column :shift_types, :short_name, :string
  end
end
