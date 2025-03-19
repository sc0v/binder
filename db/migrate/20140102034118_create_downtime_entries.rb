# frozen_string_literal: true
class CreateDowntimeEntries < ActiveRecord::Migration[6.0]
  def change
    create_table :downtime_entries do |t|
      t.datetime :started_at
      t.datetime :ended_at
      t.belongs_to :organization
    end
  end
end
