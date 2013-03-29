class CreateMembers < ActiveRecord::Migration
  def change
    create_table :members do |t|
      t.string :first_name, :null => false
      t.string :last_name, :null => false
      t.string :andrewid, :null => false
      t.boolean :chair, :null => false

      t.references :organization

      t.timestamps
    end

    add_index :members, :andrewid
  end
end
