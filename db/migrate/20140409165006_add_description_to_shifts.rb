class AddDescriptionToShifts < ActiveRecord::Migration
  def change
    add_column :shifts, :description, :string
  end
end
