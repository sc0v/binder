class RemoveCardnumberFromParticipants < ActiveRecord::Migration
  def up
    remove_column :participants, :cardnumber
  end

  def down
    add_column :participants, :cardnumber, :string
  end
end
