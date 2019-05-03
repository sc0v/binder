# ## Schema Information
#
# Table name: `org_status_type_categories`
#
# ### Columns
#
# Name          | Type               | Attributes
# ------------- | ------------------ | ---------------------------
# **`active`**  | `boolean`          |
# **`id`**      | `integer`          | `not null, primary key`
# **`name`**    | `string(255)`      | `not null`
#

class OrgStatusTypeCategory < ActiveRecord::Base
    has_many :organization_status_types
end
