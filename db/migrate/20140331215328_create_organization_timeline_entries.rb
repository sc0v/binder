# frozen_string_literal: true
class CreateOrganizationTimelineEntries < ActiveRecord::Migration[6.0]
  def change
    create_table :organization_timeline_entries do |t|
      t.datetime :started_at
      t.datetime :ended_at
      t.references :organization_timeline_entry_type, index: { name: 'index_timeline_entries_on_type' }
      t.references :organization, index: true
      t.text :description

      t.timestamps
    end
  end
end
