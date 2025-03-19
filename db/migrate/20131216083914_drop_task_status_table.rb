# frozen_string_literal: true
class DropTaskStatusTable < ActiveRecord::Migration[6.0]
  def change
    remove_reference :tasks, :task_status
    drop_table :task_statuses
    add_column :tasks, :is_completed, :boolean
  end
end
