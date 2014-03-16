class AddShortNameToOrganization < ActiveRecord::Migration
  def change
    add_column :organizations, :short_name, :string
  end
end
