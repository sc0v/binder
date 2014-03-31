class DropDowntimeEntries < ActiveRecord::Migration
  def up
    drop_table :downtime_entries
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
