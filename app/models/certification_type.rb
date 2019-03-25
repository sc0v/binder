# ## Schema Information
#
# Table name: `certification_types`
#
# ### Columns
#
# Name              | Type               | Attributes
# ----------------- | ------------------ | ---------------------------
# **`active`**      | `boolean`          | `default(TRUE)`
# **`created_at`**  | `datetime`         | `not null`
# **`id`**          | `integer`          | `not null, primary key`
# **`name`**        | `string(255)`      |
# **`updated_at`**  | `datetime`         | `not null`
#

class CertificationType < ActiveRecord::Base
  validates :name, :presence => true, :uniqueness => true
  scope :active,       -> { where(active: true) }
  scope :inactive,     -> { where(active: false) }
end
