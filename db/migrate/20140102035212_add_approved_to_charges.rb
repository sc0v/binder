class AddApprovedToCharges < ActiveRecord::Migration
  def change
    add_column :charges, :approved, :boolean
  end
end
