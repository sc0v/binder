# ## Schema Information
#
# Table name: `organization_lists`
#
# ### Columns
#
# Name                   | Type               | Attributes
# ---------------------- | ------------------ | ---------------------------
# **`andrew_id`**        | `string`           |
# **`created_at`**       | `datetime`         | `not null`
# **`id`**               | `integer`          | `not null, primary key`
# **`organization_id`**  | `integer`          |
# **`updated_at`**       | `datetime`         | `not null`
#

require 'test_helper'

class OrganizationListTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
