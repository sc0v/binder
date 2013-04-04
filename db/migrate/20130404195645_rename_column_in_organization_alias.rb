class RenameColumnInOrganizationAlias < ActiveRecord::Migration
  def up
    rename_column :organization_aliases, :alias, :name
  end

  def down
    rename_column :organization_aliases, :name, :alias
  end
end
