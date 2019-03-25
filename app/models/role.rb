# ## Schema Information
#
# Table name: `roles`
#
# ### Columns
#
# Name                 | Type               | Attributes
# -------------------- | ------------------ | ---------------------------
# **`active`**         | `boolean`          | `default(TRUE)`
# **`created_at`**     | `datetime`         |
# **`id`**             | `integer`          | `not null, primary key`
# **`name`**           | `string(255)`      |
# **`resource_id`**    | `integer`          |
# **`resource_type`**  | `string(255)`      |
# **`updated_at`**     | `datetime`         |
#
# ### Indexes
#
# * `index_roles_on_name`:
#     * **`name`**
# * `index_roles_on_name_and_resource_type_and_resource_id`:
#     * **`name`**
#     * **`resource_type`**
#     * **`resource_id`**
#

class Role < ActiveRecord::Base
  has_and_belongs_to_many :users, :join_table => :users_roles
  
  scope :active,       -> { where(active: true) }
  scope :inactive,     -> { where(active: false) }

  ROLES = [:admin]
end
