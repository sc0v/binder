# frozen_string_literal: true
class CreateChargeTypes < ActiveRecord::Migration[6.0]
  def change
    create_table :charge_types do |t|
      t.string :name
      t.boolean :requires_booth_chair_approval
      t.decimal :default_amount, precision: 8, scale: 2
      t.text :description

      t.timestamps
    end
  end
end
