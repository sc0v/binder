# ## Schema Information
#
# Table name: `organization_aliases`
#
# ### Columns
#
# Name                   | Type               | Attributes
# ---------------------- | ------------------ | ---------------------------
# **`active`**           | `boolean`          | `default(TRUE)`
# **`created_at`**       | `datetime`         |
# **`id`**               | `integer`          | `not null, primary key`
# **`name`**             | `string(255)`      |
# **`organization_id`**  | `integer`          |
# **`updated_at`**       | `datetime`         |
#
# ### Indexes
#
# * `index_organization_aliases_on_name`:
#     * **`name`**
# * `index_organization_aliases_on_organization_id`:
#     * **`organization_id`**
#

class OrganizationAlias < ActiveRecord::Base
  validates_presence_of :name, :organization
  validates_associated :organization
  validates :name, :uniqueness => true

  belongs_to :organization

  scope :search, lambda { |term| where('lower(name) LIKE lower(?)', "#{term}%") }
  scope :active,       -> { where(active: true) }
  scope :inactive,     -> { where(active: false) }

  def formatted_name
    organization.name + " (" + name + ")"
  end
end

