class CreateStoreItems < ActiveRecord::Migration
  def change
    create_table :store_items do |t|
      t.string :name
      t.decimal :price, precision: 8, scale: 2
      t.integer :quantity

      t.timestamps null: false
    end
  end
end
