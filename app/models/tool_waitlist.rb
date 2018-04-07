# ## Schema Information
#
# Table name: `tool_waitlists`
#
# ### Columns
#
# Name                   | Type               | Attributes
# ---------------------- | ------------------ | ---------------------------
# **`active`**           | `boolean`          | `default(TRUE)`
# **`created_at`**       | `datetime`         |
# **`id`**               | `integer`          | `not null, primary key`
# **`note`**             | `string(255)`      |
# **`organization_id`**  | `integer`          |
# **`participant_id`**   | `integer`          |
# **`tool_type_id`**     | `integer`          |
# **`updated_at`**       | `datetime`         |
# **`wait_start_time`**  | `datetime`         |
#
# ### Indexes
#
# * `index_tool_waitlists_on_tool_type_id`:
#     * **`tool_type_id`**
#

class ToolWaitlist < ActiveRecord::Base
  # Relationships
  belongs_to :tool_type
  belongs_to :organization
  belongs_to :participant

  # Validations
  validates_presence_of :tool_type, :organization, :participant, :wait_start_time
  validates_associated :tool_type, :organization, :participant

  # Scopes
  default_scope {where(active: true)}
  scope :for_tool_type, ->(tool_type){where(tool_type: tool_type)}
  scope :by_wait_start_time, ->{order('wait_start_time')}

  # Gets the time the org has been waiting for the tool in minutes.
  def duration_waiting
    (DateTime.current.to_time - wait_start_time.to_time) / 60
  end


end
