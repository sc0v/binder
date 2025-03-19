# frozen_string_literal: true
class CreateShiftTypes < ActiveRecord::Migration[6.0]
  def change
    create_table :shift_types do |t|
      t.string :name

      t.timestamps
    end
  end
end
