class AddWaiverStartToParticipant < ActiveRecord::Migration[4.2]
  def change
    add_column :participants, :waiver_start, :datetime
  end
end
