class RemoveColumnsFromTasks < ActiveRecord::Migration
  def change
    remove_column :tasks, :assigned_person, :integer
    remove_column :tasks, :created_by, :integer
    remove_column :tasks, :display_duration, :datetime
  end
end
