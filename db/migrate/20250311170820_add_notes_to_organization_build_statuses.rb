class AddNotesToOrganizationBuildStatuses < ActiveRecord::Migration[7.0]
  def change
    add_column :organization_build_statuses, :notes, :text
  end
end
