class CreateContactLists < ActiveRecord::Migration
  def change
    create_table :contact_lists do |t|
      t.integer :participant_id
      
      t.timestamps
    end
  end
end
