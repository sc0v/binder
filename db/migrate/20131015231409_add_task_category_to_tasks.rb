# frozen_string_literal: true
class AddTaskCategoryToTasks < ActiveRecord::Migration[6.0]
  def change
    add_column :tasks, :task_category_id, :integer
  end
end
