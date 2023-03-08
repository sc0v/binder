# frozen_string_literal: true

class AddAdminToParticipants < ActiveRecord::Migration[7.0]
  def change
    add_column :participants, :admin, :boolean
    add_index :participants, :admin
  end
end
