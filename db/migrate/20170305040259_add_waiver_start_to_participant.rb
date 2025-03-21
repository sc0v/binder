# frozen_string_literal: true
class AddWaiverStartToParticipant < ActiveRecord::Migration[6.0]
  def change
    add_column :participants, :waiver_start, :datetime
  end
end
