class AddAllAndrewIdsToShifts < ActiveRecord::Migration[8.0]
  def change
    add_column :shifts, :andrewids, :string
  end
end
