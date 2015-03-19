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

require 'test_helper'

class StoreItemTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
