class AddRedHardhatToMemberships < ActiveRecord::Migration[7.0]
  def change
    add_column :memberships, :is_red_hardhat, :boolean
  end
end
