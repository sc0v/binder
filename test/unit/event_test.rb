# ## Schema Information
#
# Table name: `events`
#
# ### Columns
#
# Name                 | Type               | Attributes
# -------------------- | ------------------ | ---------------------------
# **`created_at`**     | `datetime`         |
# **`description`**    | `text(65535)`      |
# **`event_type_id`**  | `integer`          |
# **`id`**             | `integer`          | `not null, primary key`
# **`is_done`**        | `boolean`          |
# **`updated_at`**     | `datetime`         |
#

class EventTest < ActiveSupport::TestCase
  # Relationships
  

  # Validations- 

  # Scopes

  # Methods

end