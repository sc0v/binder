# frozen_string_literal: true
class AddDescriptionToShifts < ActiveRecord::Migration[4.2]
  def change
    add_column :shifts, :description, :string
  end
end
