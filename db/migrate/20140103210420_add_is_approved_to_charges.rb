class AddIsApprovedToCharges < ActiveRecord::Migration
  def change
    add_column :charges, :is_approved, :boolean
  end
end
