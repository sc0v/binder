class CreateWaitlistEntries < ActiveRecord::Migration[7.0]
  def change
    create_table :waitlist_entries do |t|
      t.references :organization, null: false, foreign_key: true
      t.references :participant, null: false, foreign_key: true
      t.references :tool_type, null: false, foreign_key: true
      t.references :tool_waitlist, null: false, foreign_key: true
      t.integer :status, default: 1

      t.timestamps
    end
  end
end
