# ## Schema Information
#
# Table name: `documents`
#
# ### Columns
#
# Name                   | Type               | Attributes
# ---------------------- | ------------------ | ---------------------------
# **`created_at`**       | `datetime`         |
# **`document_id`**      | `integer`          |
# **`id`**               | `integer`          | `not null, primary key`
# **`name`**             | `string(255)`      |
# **`organization_id`**  | `integer`          |
# **`public`**           | `boolean`          |
# **`updated_at`**       | `datetime`         |
# **`url`**              | `string(255)`      |
#

require 'test_helper'

class DocumentTest < ActiveSupport::TestCase
  # Relationships
  should belong_to(:organization)

  # Validations

  # Scopes

  # Methods

end
