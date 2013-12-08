class AddAssignedPersonToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :assigned_person, :integer
  end
end
