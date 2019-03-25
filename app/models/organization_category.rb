# ## Schema Information
#
# Table name: `organization_categories`
#
# ### Columns
#
# Name               | Type               | Attributes
# ------------------ | ------------------ | ---------------------------
# **`active`**       | `boolean`          | `default(TRUE)`
# **`created_at`**   | `datetime`         |
# **`id`**           | `integer`          | `not null, primary key`
# **`is_building`**  | `boolean`          |
# **`name`**         | `string(255)`      |
# **`updated_at`**   | `datetime`         |
#

class OrganizationCategory < ActiveRecord::Base
  validates :name, :presence => true, :uniqueness => true

  has_many :organizations, :dependent => :destroy
  
  scope :active,       -> { where(active: true) }
  scope :inactive,     -> { where(active: false) }
  
end

