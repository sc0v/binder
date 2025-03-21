# frozen_string_literal: true
class AddParticipantIdToEvents < ActiveRecord::Migration[6.0]
  def change
    add_column :events, :participant_id, :integer
  end
end
