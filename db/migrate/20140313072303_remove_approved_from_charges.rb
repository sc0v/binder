class RemoveApprovedFromCharges < ActiveRecord::Migration[4.2]
  def change
    remove_column :charges, :approved, :boolean
  end
end
