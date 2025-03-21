# frozen_string_literal: true
class AddApprovedToCharges < ActiveRecord::Migration[6.0]
  def change
    add_column :charges, :approved, :boolean
  end
end
