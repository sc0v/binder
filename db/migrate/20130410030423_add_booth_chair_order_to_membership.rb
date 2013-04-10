class AddBoothChairOrderToMembership < ActiveRecord::Migration
  def change
    add_column :memberships, :booth_chair_order, :integer
  end
end
