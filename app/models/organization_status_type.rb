# ## Schema Information
#
# Table name: `organization_status_types`
#
# ### Columns
#
# Name                                 | Type               | Attributes
# ------------------------------------ | ------------------ | ---------------------------
# **`active`**                         | `boolean`          | `default(TRUE)`
# **`category`**                       | `string(255)`      |
# **`display`**                        | `boolean`          |
# **`id`**                             | `integer`          | `not null, primary key`
# **`name`**                           | `string(255)`      |
# **`org_status_type_categories_id`**  | `integer`          |
#

class OrganizationStatusType < ActiveRecord::Base
  validates :name, :presence => true, :uniqueness => true

  has_many :organization_statuses, dependent: :destroy
  belongs_to :org_status_type_categories
  
  scope :display,   -> { joins(:organization_status_types).where('organization_status_types.display = ?', true) }
  scope :active,       -> { where(active: true) }
  scope :inactive,     -> { where(active: false) }
  
end
