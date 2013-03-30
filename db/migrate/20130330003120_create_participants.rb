class CreateParticipants < ActiveRecord::Migration
  def change
    create_table :participants do |t|
      t.string :andrewid
      t.string :cardnumber

      t.timestamps
    end
  end
end
