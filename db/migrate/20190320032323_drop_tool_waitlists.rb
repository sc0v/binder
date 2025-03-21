# frozen_string_literal: true
class DropToolWaitlists < ActiveRecord::Migration[6.0]
  def change
    drop_table :tool_waitlists
  end
end
