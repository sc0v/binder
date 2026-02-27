# frozen_string_literal: true

class ChangeTypeToString < ActiveRecord::Migration[7.0]
  def up
    change_column :organization_build_statuses, :type, :string
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
