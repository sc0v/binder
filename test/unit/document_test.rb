# ## Schema Information
#
# Table name: `documents`
#
# ### Columns
#
# Name                   | Type               | Attributes
# ---------------------- | ------------------ | ---------------------------
# **`comments`**         | `text(65535)`      |
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

  # Validations

  # Scopes

  # Methods

end
