class AddUserIdToParticipants < ActiveRecord::Migration[4.2]
  def change
    add_column :participants, :user_id, :integer
  end
end
