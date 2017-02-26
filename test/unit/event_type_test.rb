# ## Schema Information
#
# Table name: `event_types`
#
# ### Columns
#
# Name            | Type               | Attributes
# --------------- | ------------------ | ---------------------------
# **`display`**   | `boolean`          |
# **`id`**        | `integer`          | `not null, primary key`
# **`name`**      | `string(255)`      |
#

class EventTypeTest < ActiveSupport::TestCase
  # Relationships
  should have_many(:events)
  

end