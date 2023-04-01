# frozen_string_literal: true
class DropToolWaitlists < ActiveRecord::Migration[4.2]
  def change
    drop_table :tool_waitlists
  end
end
