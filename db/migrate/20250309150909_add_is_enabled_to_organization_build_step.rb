class AddIsEnabledToOrganizationBuildStep < ActiveRecord::Migration[7.0]
  def change
    add_column :organization_build_steps, :is_enabled, :boolean
  end
end
