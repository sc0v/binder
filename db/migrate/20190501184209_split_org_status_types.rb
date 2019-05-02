class SplitOrgStatusTypes < ActiveRecord::Migration
  def change
    create_table :org_status_type_categories do |t|
      t.string :name, :null => false
      t.boolean :active
    end
    add_reference :organization_status_types, :org_status_type_categories
  end
end
