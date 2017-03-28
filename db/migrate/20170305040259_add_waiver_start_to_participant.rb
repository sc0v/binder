class AddWaiverStartToParticipant < ActiveRecord::Migration
  def change
    add_column :participants, :waiver_start, :datetime
  end
end
