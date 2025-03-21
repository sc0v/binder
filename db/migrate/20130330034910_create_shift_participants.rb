# frozen_string_literal: true
class CreateShiftParticipants < ActiveRecord::Migration[6.0]
  def change
    create_table :shift_participants do |t|
      t.references :shift
      t.references :participant
      t.datetime :clocked_in_at
      t.datetime :clocked_out_at

      t.timestamps
    end
  end
end
