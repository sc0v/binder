# ## Schema Information
#
# Table name: `organization_categories`
#
# ### Columns
#
# Name                   | Type               | Attributes
# ---------------------- | ------------------ | ---------------------------
# **`building_status`**  | `boolean`          |
# **`created_at`**       | `datetime`         |
# **`id`**               | `integer`          | `not null, primary key`
# **`name`**             | `string(255)`      |
# **`updated_at`**       | `datetime`         |
#

class OrganizationCategory < ActiveRecord::Base
  validates :name, :presence => true, :uniqueness => true

  has_many :organizations, :dependent => :destroy
end

