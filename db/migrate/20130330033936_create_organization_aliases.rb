class CreateOrganizationAliases < ActiveRecord::Migration
  def change
    create_table :organization_aliases do |t|
      t.string :alias
      t.references :organization

      t.timestamps
    end
    add_index :organization_aliases, :organization_id
    add_index :organization_aliases, :alias
  end
end
