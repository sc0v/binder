class ChangeDisplayDurationInTasks < ActiveRecord::Migration[4.2]
  def up
    remove_column :tasks, :display_duration
    add_column :tasks, :display_duration, :datetime
  end

  def down
    remove_column :tasks, :display_duration
    add_column :tasks, :display_duration, :time
  end
end
