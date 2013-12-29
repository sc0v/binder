class RemoveClockedOutAtFromShiftParticipants < ActiveRecord::Migration
  def change
    remove_column :shift_participants, :clocked_out_at, :datetime
  end
end
