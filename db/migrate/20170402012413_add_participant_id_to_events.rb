class AddParticipantIdToEvents < ActiveRecord::Migration
  def change
    add_column :events, :participant_id, :integer
  end
end
