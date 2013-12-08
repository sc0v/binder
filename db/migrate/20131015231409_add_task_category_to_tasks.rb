class AddTaskCategoryToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :task_category_id, :integer
  end
end
