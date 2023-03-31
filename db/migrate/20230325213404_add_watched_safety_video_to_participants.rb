# frozen_string_literal: true
class AddWatchedSafetyVideoToParticipants < ActiveRecord::Migration[7.0]
  def change
    add_column :participants, :watched_safety_video, :boolean
  end
end
