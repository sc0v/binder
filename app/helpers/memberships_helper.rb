# ## Schema Information
#
# Table name: `memberships`
#
# ### Columns
#
# Name                     | Type               | Attributes
# ------------------------ | ------------------ | ---------------------------
# **`active`**             | `boolean`          | `default(TRUE)`
# **`booth_chair_order`**  | `integer`          |
# **`created_at`**         | `datetime`         |
# **`id`**                 | `integer`          | `not null, primary key`
# **`is_booth_chair`**     | `boolean`          |
# **`organization_id`**    | `integer`          |
# **`participant_id`**     | `integer`          |
# **`title`**              | `string(255)`      |
# **`updated_at`**         | `datetime`         |
#
# ### Indexes
#
# * `index_memberships_on_organization_id`:
#     * **`organization_id`**
# * `index_memberships_on_participant_id`:
#     * **`participant_id`**
#

module MembershipsHelper
end
