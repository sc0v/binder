# frozen_string_literal: true

require 'test_helper'

class StorePurchaseTest < ActiveSupport::TestCase
  # relationships
  should have_one(:organization).through(:charge)
  should belong_to(:charge)
  should belong_to(:store_item)

  # methods

  context 'With a proper context, ' do
    setup do
      # Create store
      @store_item = FactoryGirl.create(:store_item, name: 'Hammer', price: 20, quantity: 3)
      # Create store_purchase
      @store_purchase = FactoryGirl.create(:store_purchase, price_at_purchase: 20, quantity_purchased: 1,
                                                            store_item_id: @store_item.id)
    end

    teardown do
    end

    should 'show that items_in_cart works properly' do
      assert_equal [@store_purchase], StorePurchase.items_in_cart
    end

    should 'show that items_in_cart? works properly' do
      assert_equal true, StorePurchase.items_in_cart?
    end
  end
end
