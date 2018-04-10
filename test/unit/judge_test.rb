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

require 'test_helper'

class JudgeTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
