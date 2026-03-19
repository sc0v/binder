# frozen_string_literal: true

class DropToolWaitlists < ActiveRecord::Migration[6.0]
  def up
    drop_table :tool_waitlists
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
