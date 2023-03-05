class RemoveClockedOutAtFromShiftParticipants < ActiveRecord::Migration[4.2]
  def change
    remove_column :shift_participants, :clocked_out_at, :datetime
  end
end
