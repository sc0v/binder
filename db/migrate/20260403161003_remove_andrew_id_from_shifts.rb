class RemoveAndrewIdFromShifts < ActiveRecord::Migration[8.0]
  def change
    remove_column :shifts, :andrew_id, :string
  end
end
