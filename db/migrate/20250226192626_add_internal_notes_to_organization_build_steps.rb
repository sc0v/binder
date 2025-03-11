class AddInternalNotesToOrganizationBuildSteps < ActiveRecord::Migration[7.0]
  def change
    add_column :organization_build_steps, :internal_notes, :text
  end
end
