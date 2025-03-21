# frozen_string_literal: true
class CreateTasks < ActiveRecord::Migration[6.0]
  def change
    create_table :tasks do |t|
      t.datetime :due_at
      t.time :display_duration
      t.integer :completed_by_id
      t.string :name
      t.text :description
      t.references :task_status

      t.timestamps
    end
  end
end
