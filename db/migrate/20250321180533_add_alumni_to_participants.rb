# frozen_string_literal: true

class AddAlumniToParticipants < ActiveRecord::Migration[7.0]
  def change
    add_column :participants, :alumni, :boolean, null: false, default: false
  end
end
