# frozen_string_literal: true

class DropOrganizationStatusTypes < ActiveRecord::Migration[7.0]
  def up
    drop_table :organization_status_types
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
