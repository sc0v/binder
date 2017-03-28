class AddIsBuildingToOrganizationCategory < ActiveRecord::Migration
  def change
    add_column :organization_categories, :is_building, :boolean
  end
end
