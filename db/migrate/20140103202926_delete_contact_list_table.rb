# frozen_string_literal: true

class DeleteContactListTable < ActiveRecord::Migration[6.0]
  def up
    drop_table :contact_lists
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
