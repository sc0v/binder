# ## Schema Information
#
# Table name: `org_status_type_categories`
#
# ### Columns
#
# Name              | Type               | Attributes
# ----------------- | ------------------ | ---------------------------
# **`active`**      | `boolean`          |
# **`electrical`**  | `string(255)`      |
# **`general`**     | `string(255)`      |
# **`id`**          | `integer`          | `not null, primary key`
# **`name`**        | `string(255)`      | `not null`
# **`structural`**  | `string(255)`      |
#

class OrgStatusTypeCategory < ActiveRecord::Base
    has_many :organization_status_types
end
