# frozen_string_literal: true

class DropOrganizationTimelineEntryTypes < ActiveRecord::Migration[7.0]
  def up
    drop_table :organization_timeline_entry_types
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
