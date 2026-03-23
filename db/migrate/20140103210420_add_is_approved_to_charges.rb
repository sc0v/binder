# frozen_string_literal: true

class AddIsApprovedToCharges < ActiveRecord::Migration[6.0]
  def change
    add_column :charges, :is_approved, :boolean, null: false, default: false
  end
end
