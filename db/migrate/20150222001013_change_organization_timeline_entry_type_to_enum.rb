# frozen_string_literal: true
class ChangeOrganizationTimelineEntryTypeToEnum < ActiveRecord::Migration[6.0]
  def change
    remove_column :organization_timeline_entries, :organization_timeline_entry_type_id, :integer
    add_column :organization_timeline_entries, :entry_type, :integer
  end
end
