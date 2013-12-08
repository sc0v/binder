class AddUserIdToParticipants < ActiveRecord::Migration
  def change
    add_column :participants, :user_id, :integer
  end
end
