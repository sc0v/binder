# frozen_string_literal: true

class RenameColumnInOrganizationAlias < ActiveRecord::Migration[4.2]
  def up
    rename_column :organization_aliases, :alias, :name
  end

  def down
    rename_column :organization_aliases, :name, :alias
  end
end
