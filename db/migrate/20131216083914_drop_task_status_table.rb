# frozen_string_literal: true

class DropTaskStatusTable < ActiveRecord::Migration[6.0]
  def up
    remove_reference :tasks, :task_status
    drop_table :task_statuses
    add_column :tasks, :is_completed, :boolean
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
