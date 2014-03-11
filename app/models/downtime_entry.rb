# ## Schema Information
#
# Table name: `downtime_entries`
#
# ### Columns
#
# Name                   | Type               | Attributes
# ---------------------- | ------------------ | ---------------------------
# **`ended_at`**         | `datetime`         |
# **`id`**               | `integer`          | `not null, primary key`
# **`organization_id`**  | `integer`          |
# **`started_at`**       | `datetime`         |
#

class DowntimeEntry < ActiveRecord::Base
  validates_presence_of :organization, :started_at
  validates_associated :organization

  belongs_to :organization
end

