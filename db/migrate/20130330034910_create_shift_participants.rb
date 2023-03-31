# frozen_string_literal: true
class CreateShiftParticipants < ActiveRecord::Migration[4.2]
  def change
    create_table :shift_participants do |t|
      t.references :shift
      t.references :participant
      t.datetime :clocked_in_at
      t.datetime :clocked_out_at

      t.timestamps
    end
    add_index :shift_participants, :shift_id
    add_index :shift_participants, :participant_id
  end
end
