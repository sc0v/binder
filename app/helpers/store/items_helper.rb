# frozen_string_literal: true
module Store::ItemsHelper
  def show_cart?
    StorePurchase.items_in_cart?
  end
end
