class UpdateToolWaitlists < ActiveRecord::Migration[7.0]
  def up
    add_column :tool_waitlists, :start_at, :datetime
    add_column :tool_waitlists, :end_at, :datetime
    remove_column :tool_waitlists, :wait_start_time, :datetime
    remove_column :tool_waitlists, :participant, :references
    remove_column :tool_waitlists, :organization, :references
    remove_column :tool_waitlists, :active, :boolean
  end

  def down
    remove_column :tool_waitlists, :start_at, :datetime
    remove_column :tool_waitlists, :end_at, :datetime
    add_column :tool_waitlists, :wait_start_time, :datetime
    add_column :tool_waitlists, :participant, :references
    add_column :tool_waitlists, :organization, :references
    add_column :tool_waitlists, :active, :boolean
  end
end
