class RenameTypeColumn < ActiveRecord::Migration[7.0]
  def change
    rename_column :organization_build_statuses, :type, :status_type
  end
end
