# frozen_string_literal: true
class AddTaskCategoryToTasks < ActiveRecord::Migration[4.2]
  def change
    add_column :tasks, :task_category_id, :integer
  end
end
