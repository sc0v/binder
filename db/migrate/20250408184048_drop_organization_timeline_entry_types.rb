class DropOrganizationTimelineEntryTypes < ActiveRecord::Migration[7.0]
  def change
    drop_table :organization_timeline_entry_types
  end
end
