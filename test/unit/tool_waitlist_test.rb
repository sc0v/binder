# ## Schema Information
#
# Table name: `tool_waitlists`
#
# ### Columns
#
# Name                   | Type               | Attributes
# ---------------------- | ------------------ | ---------------------------
# **`active`**           | `boolean`          | `default(TRUE)`
# **`created_at`**       | `datetime`         |
# **`id`**               | `integer`          | `not null, primary key`
# **`note`**             | `string(255)`      |
# **`organization_id`**  | `integer`          |
# **`participant_id`**   | `integer`          |
# **`tool_type_id`**     | `integer`          |
# **`updated_at`**       | `datetime`         |
# **`wait_start_time`**  | `datetime`         |
#
# ### Indexes
#
# * `index_tool_waitlists_on_tool_type_id`:
#     * **`tool_type_id`**
#

require 'test_helper'

class ToolWaitlistTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
