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
# **`name`**        | `string`           |
# **`updated_at`**  | `datetime`         | `not null`
#

class PhoneCarrier < ActiveRecord::Base
end
