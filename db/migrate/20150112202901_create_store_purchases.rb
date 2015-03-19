class CreateStorePurchases < ActiveRecord::Migration
  def change
    create_table :store_purchases do |t|
      t.references :charge, index: true
      t.references :store_item, index: true
      t.decimal :price_at_purchase
      t.integer :quantity_purchased

      t.timestamps null: false
    end
    add_foreign_key :store_purchases, :charges
    add_foreign_key :store_purchases, :store_items
  end
end
