class AddNumberOfParticipantsToShifts < ActiveRecord::Migration[8.0]
  def change
    add_column :shifts, :capacity, :integer
  end
end
