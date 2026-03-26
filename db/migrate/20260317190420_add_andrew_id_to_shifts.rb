class AddAndrewIdToShifts < ActiveRecord::Migration[8.0]
  def change
    add_column :shifts, :andrew_id, :string
  end
end
