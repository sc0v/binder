class CreateOrganizationLists < ActiveRecord::Migration
  def change
    create_table :organization_lists do |t|
      t.string :organization_name
      t.string :andrew_id

      t.timestamps null: false
    end
  end
end
