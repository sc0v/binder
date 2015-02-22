# ## Schema Information
#
# Table name: `organization_timeline_entries`
#
# ### Columns
#
# Name                   | Type               | Attributes
# ---------------------- | ------------------ | ---------------------------
# **`created_at`**       | `datetime`         |
# **`description`**      | `text(65535)`      |
# **`ended_at`**         | `datetime`         |
# **`entry_type`**       | `integer`          |
# **`id`**               | `integer`          | `not null, primary key`
# **`organization_id`**  | `integer`          |
# **`started_at`**       | `datetime`         |
# **`updated_at`**       | `datetime`         |
#
# ### Indexes
#
# * `index_organization_timeline_entries_on_organization_id`:
#     * **`organization_id`**
#

class OrganizationTimelineEntry < ActiveRecord::Base
  validates_presence_of :organization, :started_at
  validates_associated :organization

  enum entry_type: { structural: 0, electrical: 1, downtime: 2}

  belongs_to :organization, :touch => true

  default_scope { order('started_at asc') }
  scope :current, -> { where(ended_at: nil) }

  def duration
    return ended_at.to_i - started_at.to_i unless ended_at.blank?
    return DateTime.now.to_i - started_at.to_i
  end
end

