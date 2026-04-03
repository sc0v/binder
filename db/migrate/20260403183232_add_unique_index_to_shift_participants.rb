class AddUniqueIndexToShiftParticipants < ActiveRecord::Migration[8.0]
  def change
    add_index :shift_participants, %i[shift_id participant_id], unique: true
  end
end
