# ## Schema Information
#
# Table name: `store_items`
#
# ### Columns
#
# Name              | Type               | Attributes
# ----------------- | ------------------ | ---------------------------
# **`active`**      | `boolean`          | `default(TRUE)`
# **`created_at`**  | `datetime`         | `not null`
# **`id`**          | `integer`          | `not null, primary key`
# **`in_stock`**    | `boolean`          |
# **`name`**        | `string(255)`      |
# **`price`**       | `decimal(8, 2)`    |
# **`updated_at`**  | `datetime`         | `not null`
#

require 'test_helper'

class StoreItemTest < ActiveSupport::TestCase

  #relationships

  should have_many(:store_purchases)

  #methods
  
  context "With a proper context, " do
    setup do
      # Create store 
      @store_item = FactoryGirl.create(:store_item, :name => "Hammer", :price => 20, :in_stock => true)
      # Create charge 
      @charge = FactoryGirl.create(:charge, :is_approved => true)
      # Create store_purchase 
      @store_purchase = FactoryGirl.create(:store_purchase, :price_at_purchase => 20, :quantity_purchased => 1, :store_item_id => @store_item.id)
    end

    teardown do
    end

  end
end
