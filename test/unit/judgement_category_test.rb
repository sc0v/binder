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

require 'test_helper'

class JudgementCategoryTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
