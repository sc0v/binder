# frozen_string_literal: true
class CreateToolWaitlists < ActiveRecord::Migration[4.2]
  def change
    create_table :tool_waitlists do |t|
      t.references :tool_type, index: true
      t.datetime :wait_start_time
      t.references :participant
      t.references :organization
      t.string :note
      t.boolean :active, default: true

      t.timestamps
    end
  end
end
