class AddBuildingStatusToOrganizationCategory < ActiveRecord::Migration
  def change
    add_column :organization_categories, :building_status, :boolean
  end
end
