class CreateOrganizationCategories < ActiveRecord::Migration
  def change
    create_table :organization_categories do |t|
      t.string :name

      t.timestamps
    end
  end
end
