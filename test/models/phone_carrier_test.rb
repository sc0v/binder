# ## Schema Information
#
# Table name: `phone_carriers`
#
# ### Columns
#
# Name              | Type               | Attributes
# ----------------- | ------------------ | ---------------------------
# **`created_at`**  | `datetime`         | `not null`
# **`id`**          | `integer`          | `not null, primary key`
# **`name`**        | `string(255)`      |
# **`updated_at`**  | `datetime`         | `not null`
#

require 'test_helper'

class PhoneCarrierTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
