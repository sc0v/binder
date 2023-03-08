# frozen_string_literal: true

class AddParticipantIdToEvents < ActiveRecord::Migration[4.2]
  def change
    add_column :events, :participant_id, :integer
  end
end
