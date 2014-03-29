class AddCreatingParticipantToCharges < ActiveRecord::Migration
  def change
    add_column :charges, :creating_participant_id, :integer
  end
end
