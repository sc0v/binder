# frozen_string_literal: true
class AddApprovedToCharges < ActiveRecord::Migration[4.2]
  def change
    add_column :charges, :approved, :boolean
  end
end
