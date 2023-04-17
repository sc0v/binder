class CreateToolWaitlistEntries < ActiveRecord::Migration[7.0]
  def change
    create_table :tool_waitlist_entries do |t|
      t.references :organization, null: false, foreign_key: true
      t.references :participant, null: false, foreign_key: true
      t.references :tool_waitlist, null: false, foreign_key: true
      t.datetime :start_at
      t.datetime :end_at
      t.string :note
      t.integer :status, default: 1

      t.timestamps
    end
  end
end
