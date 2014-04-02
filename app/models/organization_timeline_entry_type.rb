# ## Schema Information
#
# Table name: `organization_timeline_entry_types`
#
# ### Columns
#
# Name              | Type               | Attributes
# ----------------- | ------------------ | ---------------------------
# **`created_at`**  | `datetime`         |
# **`id`**          | `integer`          | `not null, primary key`
# **`name`**        | `string(255)`      |
# **`updated_at`**  | `datetime`         |
#

class OrganizationTimelineEntryType < ActiveRecord::Base
  validates_presence_of :name
  validates_uniqueness_of :name

  has_many :organization_time_entries

end

