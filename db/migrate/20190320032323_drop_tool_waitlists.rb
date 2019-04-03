class DropToolWaitlists < ActiveRecord::Migration
  def change
    drop_table :tool_waitlists
  end
end
