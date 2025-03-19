# frozen_string_literal: true
class RemoveClockedOutAtFromShiftParticipants < ActiveRecord::Migration[6.0]
  def change
    remove_column :shift_participants, :clocked_out_at, :datetime
  end
end
