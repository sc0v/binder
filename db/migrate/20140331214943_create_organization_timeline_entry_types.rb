# frozen_string_literal: true
class CreateOrganizationTimelineEntryTypes < ActiveRecord::Migration[6.0]
  def change
    create_table :organization_timeline_entry_types do |t|
      t.string :name

      t.timestamps
    end
  end
end
