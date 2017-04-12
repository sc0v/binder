class ChangeStoreItemPriceDatatype < ActiveRecord::Migration
  def change
    change_column :store_items, :price, :decimal, :precision => 8, :scale => 2
    change_column :store_purchases, :price_at_purchase, :decimal, :precision => 8, :scale => 2
  end
end
