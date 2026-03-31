class AddBoothTypeToOrganizations < ActiveRecord::Migration[8.0]
  def change
    add_column :organizations, :booth_type, :string
  end
end
