module Store::ItemsHelper

  def show_cart?
    StorePurchase.items_in_cart?
  end

end
