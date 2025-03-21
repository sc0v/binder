# frozen_string_literal: true
class RemoveApprovedFromCharges < ActiveRecord::Migration[6.0]
  def change
    remove_column :charges, :approved, :boolean
  end
end
