class ChangeStoreItemQuantityToInStock < ActiveRecord::Migration
  def change
    remove_column :store_items, :quantity, :integer
    add_column :store_items, :in_stock, :boolean
  end
end
