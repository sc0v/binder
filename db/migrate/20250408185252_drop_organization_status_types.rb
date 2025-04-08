class DropOrganizationStatusTypes < ActiveRecord::Migration[7.0]
  def change
    drop_table :organization_status_types
  end
end
