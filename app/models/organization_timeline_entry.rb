# ## Schema Information
#
# Table name: `organization_timeline_entries`
#
# ### Columns
#
# Name                                       | Type               | Attributes
# ------------------------------------------ | ------------------ | ---------------------------
# **`created_at`**                           | `datetime`         |
# **`description`**                          | `text`             |
# **`ended_at`**                             | `datetime`         |
# **`id`**                                   | `integer`          | `not null, primary key`
# **`organization_id`**                      | `integer`          |
# **`organization_timeline_entry_type_id`**  | `integer`          |
# **`started_at`**                           | `datetime`         |
# **`updated_at`**                           | `datetime`         |
#
# ### Indexes
#
# * `index_organization_timeline_entries_on_organization_id`:
#     * **`organization_id`**
# * `index_timeline_entries_on_type`:
#     * **`organization_timeline_entry_type_id`**
#

class OrganizationTimelineEntry < ActiveRecord::Base
  validates_presence_of :organization, :organization_timeline_entry_type, :started_at
  validates_associated :organization, :organization_timeline_entry_type

  belongs_to :organization_timeline_entry_type
  belongs_to :organization, :touch => true

  default_scope { order('started_at asc') }
  scope :current, -> { where(ended_at: nil) }
  scope :structural, -> { joins(:organization_timeline_entry_type).where(organization_timeline_entry_types: {name: 'Structural Queue'}) }
  scope :electrical, -> { joins(:organization_timeline_entry_type).where(organization_timeline_entry_types: {name: 'Electrical Queue'}) }
  scope :downtime, -> { joins(:organization_timeline_entry_type).where(organization_timeline_entry_types: {name: 'Downtime'}) }
end

