class DropTaskCategories < ActiveRecord::Migration
  def change
    remove_reference :tasks, :task_category
    drop_table :task_categories
  end
end
