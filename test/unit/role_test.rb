# ## Schema Information
#
# Table name: `roles`
#
# ### Columns
#
# Name                 | Type               | Attributes
# -------------------- | ------------------ | ---------------------------
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

require 'test_helper'

class RoleTest < ActiveSupport::TestCase
  # Relationships

  should have_and_belong_to_many(:users)

  # Validations

  # Scopes

  # Methods

end
