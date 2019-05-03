# ## Schema Information
#
# Table name: `organization_status_types`
#
# ### Columns
#
# Name                                 | Type               | Attributes
# ------------------------------------ | ------------------ | ---------------------------
# **`active`**                         | `boolean`          | `default(TRUE)`
# **`display`**                        | `boolean`          |
# **`id`**                             | `integer`          | `not null, primary key`
# **`name`**                           | `string(255)`      |
# **`org_status_type_categories_id`**  | `integer`          |
#

class OrganizationStatusType < ActiveRecord::Base
  validates :name, :presence => true, :uniqueness => true

  has_many :organization_statuses, dependent: :destroy
  belongs_to :org_status_type_categories
  
  scope :active,       -> { where(active: true) }
  scope :inactive,     -> { where(active: false) }
end
