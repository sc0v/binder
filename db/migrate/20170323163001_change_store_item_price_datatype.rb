# frozen_string_literal: true
class ChangeStoreItemPriceDatatype < ActiveRecord::Migration[4.2]
  def change
    change_column :store_items, :price, :decimal, precision: 8, scale: 2
    change_column :store_purchases, :price_at_purchase, :decimal, precision: 8, scale: 2
  end
end
