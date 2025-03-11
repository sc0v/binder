class AddApproverToOrganizationBuildSteps < ActiveRecord::Migration[7.0]
  def change
    remove_column :organization_build_steps, :completed, :boolean
    add_reference :organization_build_steps, :approver, null: true, foreign_key: { to_table: :participants }
  end
end
