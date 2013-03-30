class AddDetailsToMembership < ActiveRecord::Migration
  def change
    add_column :memberships, :is_booth_chair, :boolean
    add_column :memberships, :title, :string

    remove_column :memberships, :is_chair
  end
end
