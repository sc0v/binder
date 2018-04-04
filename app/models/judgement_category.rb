# ## Schema Information
#
# Table name: `judgement_categories`
#
# ### Columns
#
# Name               | Type               | Attributes
# ------------------ | ------------------ | ---------------------------
# **`created_at`**   | `datetime`         | `not null`
# **`description`**  | `string`           |
# **`grouping`**     | `integer`          |
# **`id`**           | `integer`          | `not null, primary key`
# **`max_value`**    | `integer`          |
# **`name`**         | `string`           |
# **`updated_at`**   | `datetime`         | `not null`
#

class JudgementCategory < ActiveRecord::Base
  enum grouping: {design: 0, game: 1, evening: 2, other: 3}
end
