# frozen_string_literal: true
class CreatePhoneCarriers < ActiveRecord::Migration[6.0]
  def change
    create_table :phone_carriers do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
