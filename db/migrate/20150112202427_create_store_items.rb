# frozen_string_literal: true
class CreateStoreItems < ActiveRecord::Migration[6.0]
  def change
    create_table :store_items do |t|
      t.string :name
      t.decimal :price
      t.integer :quantity

      t.timestamps null: false
    end
  end
end
