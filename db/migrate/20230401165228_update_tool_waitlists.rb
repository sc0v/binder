class UpdateToolWaitlists < ActiveRecord::Migration[7.0]
  def up
    add_column :tool_waitlists, :start_at, :datetime
    add_column :tool_waitlists, :end_at, :datetime
    remove_column :tool_waitlists, :wait_start_time, :datetime
  end

  def down
    remove_column :tool_waitlists, :start_at, :datetime
    remove_column :tool_waitlists, :end_at, :datetime
    add_column :tool_waitlists, :wait_start_time, :datetime
  end
end
