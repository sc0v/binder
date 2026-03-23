# frozen_string_literal: true

class DropTaskCategories < ActiveRecord::Migration[6.0]
  def up
    remove_reference :tasks, :task_category
    drop_table :task_categories
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
