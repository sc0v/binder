# frozen_string_literal: true
class DropTaskCategories < ActiveRecord::Migration[6.0]
  def change
    remove_reference :tasks, :task_category
    drop_table :task_categories
  end
end
