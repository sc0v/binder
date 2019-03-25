# ## Schema Information
#
# Table name: `checkouts`
#
# ### Columns
#
# Name                   | Type               | Attributes
# ---------------------- | ------------------ | ---------------------------
# **`active`**           | `boolean`          | `default(TRUE)`
# **`checked_in_at`**    | `datetime`         |
# **`checked_out_at`**   | `datetime`         |
# **`created_at`**       | `datetime`         |
# **`id`**               | `integer`          | `not null, primary key`
# **`organization_id`**  | `integer`          |
# **`participant_id`**   | `integer`          |
# **`tool_id`**          | `integer`          |
# **`updated_at`**       | `datetime`         |
#
# ### Indexes
#
# * `index_checkouts_on_tool_id`:
#     * **`tool_id`**
#

module CheckoutsHelper
end
