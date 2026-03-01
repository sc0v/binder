# frozen_string_literal: true

class DropOrganizationAliases < ActiveRecord::Migration[7.0]
  def up
    remove_reference :organizations, :organization_aliases
    drop_table :organization_aliases
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
