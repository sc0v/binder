# ## Schema Information
#
# Table name: `store_purchases`
#
# ### Columns
#
# Name                      | Type               | Attributes
# ------------------------- | ------------------ | ---------------------------
# **`charge_id`**           | `integer`          |
# **`created_at`**          | `datetime`         | `not null`
# **`id`**                  | `integer`          | `not null, primary key`
# **`price_at_purchase`**   | `decimal(10, )`    |
# **`quantity_purchased`**  | `integer`          |
# **`store_item_id`**       | `integer`          |
# **`updated_at`**          | `datetime`         | `not null`
#
# ### Indexes
#
# * `index_store_purchases_on_charge_id`:
#     * **`charge_id`**
# * `index_store_purchases_on_store_item_id`:
#     * **`store_item_id`**
#

class StorePurchase < ActiveRecord::Base
  #relationships
  belongs_to :charge
  belongs_to :store_item
  has_one :organization, through: :charge

  #methods
  def self.items_in_cart
    self.where(charge: nil)
  end

  def self.items_in_cart?
    items_in_cart.size > 0
  end

end
