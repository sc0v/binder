class RemoveApprovedFromCharges < ActiveRecord::Migration
  def change
    remove_column :charges, :approved, :boolean
  end
end
