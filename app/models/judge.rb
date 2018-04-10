# ## Schema Information
#
# Table name: `judges`
#
# ### Columns
#
# Name              | Type               | Attributes
# ----------------- | ------------------ | ---------------------------
# **`category`**    | `integer`          |
# **`created_at`**  | `datetime`         | `not null`
# **`id`**          | `integer`          | `not null, primary key`
# **`name`**        | `string`           |
# **`updated_at`**  | `datetime`         | `not null`
#

class Judge < ActiveRecord::Base
end
