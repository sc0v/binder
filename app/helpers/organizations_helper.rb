# ## Schema Information
#
# Table name: `organizations`
#
# ### Columns
#
# Name                            | Type               | Attributes
# ------------------------------- | ------------------ | ---------------------------
# **`created_at`**                | `datetime`         |
# **`id`**                        | `integer`          | `not null, primary key`
# **`name`**                      | `string`           |
# **`organization_category_id`**  | `integer`          |
# **`short_name`**                | `string`           |
# **`updated_at`**                | `datetime`         |
#
# ### Indexes
#
# * `index_organizations_on_organization_category_id`:
#     * **`organization_category_id`**
#

module OrganizationsHelper
end
