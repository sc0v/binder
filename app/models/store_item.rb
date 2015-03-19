# ## Schema Information
#
# Table name: `store_items`
#
# ### Columns
#
# Name              | Type               | Attributes
# ----------------- | ------------------ | ---------------------------
# **`created_at`**  | `datetime`         | `not null`
# **`id`**          | `integer`          | `not null, primary key`
# **`name`**        | `string(255)`      |
# **`price`**       | `decimal(10, )`    |
# **`quantity`**    | `integer`          |
# **`updated_at`**  | `datetime`         | `not null`
#

class StoreItem < ActiveRecord::Base
  has_many :store_purchases

  def quantity_available
    self.quantity - (self.store_purchases.where(charge: nil).pluck(:quantity_purchased).inject{|sum,x| sum + x } || 0 )
  end
end
