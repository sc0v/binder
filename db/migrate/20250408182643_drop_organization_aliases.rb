class DropOrganizationAliases < ActiveRecord::Migration[7.0]
  def change
    remove_reference :organizations, :organization_aliases
    drop_table :organization_aliases
  end
end
