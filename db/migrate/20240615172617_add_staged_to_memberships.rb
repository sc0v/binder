class AddStagedToMemberships < ActiveRecord::Migration[7.0]
  def change
    add_column :memberships, :is_staged, :boolean
  end
end
