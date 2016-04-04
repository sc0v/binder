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

class EventType < ActiveRecord::Base
  has_many :events, dependent: :destroy
end
