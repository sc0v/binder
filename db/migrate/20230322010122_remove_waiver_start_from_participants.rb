# frozen_string_literal: true
class RemoveWaiverStartFromParticipants < ActiveRecord::Migration[7.0]
  def up
    remove_column :participants, :waiver_start
  end

  def down
    add_column :participants, :waiver_start, :datetime
  end
end
