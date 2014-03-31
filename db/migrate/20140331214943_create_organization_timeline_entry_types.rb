class CreateOrganizationTimelineEntryTypes < ActiveRecord::Migration
  def change
    create_table :organization_timeline_entry_types do |t|
      t.string :name

      t.timestamps
    end
  end
end
