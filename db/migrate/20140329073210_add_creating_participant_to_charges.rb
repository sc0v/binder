# frozen_string_literal: true

class AddCreatingParticipantToCharges < ActiveRecord::Migration[4.2]
  def change
    add_column :charges, :creating_participant_id, :integer
  end
end
