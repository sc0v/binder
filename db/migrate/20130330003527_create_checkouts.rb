class CreateCheckouts < ActiveRecord::Migration
  def change
    create_table :checkouts do |t|
      t.references :membership
      t.references :tool

      t.timestamps
    end
    add_index :checkouts, :membership_id
    add_index :checkouts, :tool_id
  end
end
