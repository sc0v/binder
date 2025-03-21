class AddApprovedAtToOrganizationBuildSteps < ActiveRecord::Migration[7.0]
  def change
    add_column :organization_build_steps, :approved_at, :datetime
  end
end
