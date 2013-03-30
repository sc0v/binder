class CreateOrganizations < ActiveRecord::Migration
  def change
    create_table :organizations do |t|
      t.string :name
      t.references :organization_category

      t.timestamps
    end
    add_index :organizations, :organization_category_id
  end
end
