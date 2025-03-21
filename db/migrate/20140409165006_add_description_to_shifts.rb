# frozen_string_literal: true
class AddDescriptionToShifts < ActiveRecord::Migration[6.0]
  def change
    add_column :shifts, :description, :string
  end
end
