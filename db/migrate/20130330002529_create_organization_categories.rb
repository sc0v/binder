class CreateOrganizationCategories < ActiveRecord::Migration[4.2]
  def change
    create_table :organization_categories do |t|
      t.string :name

      t.timestamps
    end
  end
end
