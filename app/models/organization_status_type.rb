# ## Schema Information
#
# Table name: `organization_status_types`
#
# ### Columns
#
# Name           | Type               | Attributes
# -------------- | ------------------ | ---------------------------
# **`active`**   | `boolean`          | `default(TRUE)`
# **`display`**  | `boolean`          |
# **`id`**       | `integer`          | `not null, primary key`
# **`name`**     | `string(255)`      |
#

class OrganizationStatusType < ActiveRecord::Base
  validates :name, :presence => true, :uniqueness => true

  has_many :organization_statuses, dependent: :destroy
  scope :active,       -> { where(active: true) }
  scope :inactive,     -> { where(active: false) }
end
