class ChangeDisplayDurationInTasks < ActiveRecord::Migration
  def up
    change_column :tasks, :display_duration, :datetime 
  end

  def down
    change_column :tasks, :display_duration, :time
  end
end
