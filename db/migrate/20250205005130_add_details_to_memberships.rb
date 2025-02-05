class AddDetailsToMemberships < ActiveRecord::Migration[7.0]
  def change
    add_column :memberships, :is_in_csv, :boolean
    add_column :memberships, :is_added_by_csv, :boolean
  end
end
