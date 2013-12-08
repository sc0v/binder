class AddCreatedByToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :created_by, :integer
  end
end
