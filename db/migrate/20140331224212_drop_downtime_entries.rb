# frozen_string_literal: true
class DropDowntimeEntries < ActiveRecord::Migration[4.2]
  def up
    drop_table :downtime_entries
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
