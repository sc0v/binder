class RemoveIsStagedFromMemberships < ActiveRecord::Migration[7.0]
  def change
    remove_column :memberships, :is_staged, :boolean
  end
end
