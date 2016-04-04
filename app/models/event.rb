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

class Event < ActiveRecord::Base
      belongs_to :event_type
      scope :displayable, -> { joins(:event_type).where(is_done:false).where('event_types.display = ?', true) }
end
