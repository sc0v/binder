class AddAssignedPersonToTasks < ActiveRecord::Migration[4.2]
  def change
    add_column :tasks, :assigned_person, :integer
  end
end
