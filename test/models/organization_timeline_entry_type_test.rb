# ## Schema Information
#
# Table name: `organization_timeline_entry_types`
#
# ### Columns
#
# Name              | Type               | Attributes
# ----------------- | ------------------ | ---------------------------
# **`created_at`**  | `datetime`         |
# **`id`**          | `integer`          | `not null, primary key`
# **`name`**        | `string(255)`      |
# **`updated_at`**  | `datetime`         |
#

require 'test_helper'

class OrganizationTimelineEntryTypeTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
