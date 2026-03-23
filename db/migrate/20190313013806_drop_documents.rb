# frozen_string_literal: true

class DropDocuments < ActiveRecord::Migration[6.0]
  def up
    drop_table :documents
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
