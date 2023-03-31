# frozen_string_literal: true
class RemoveCardnumberFromParticipants < ActiveRecord::Migration[4.2]
  def up
    remove_column :participants, :cardnumber
  end

  def down
    add_column :participants, :cardnumber, :string
  end
end
