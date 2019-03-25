# ## Schema Information
#
# Table name: `shift_types`
#
# ### Columns
#
# Name              | Type               | Attributes
# ----------------- | ------------------ | ---------------------------
# **`active`**      | `boolean`          | `default(TRUE)`
# **`created_at`**  | `datetime`         |
# **`id`**          | `integer`          | `not null, primary key`
# **`name`**        | `string(255)`      |
# **`short_name`**  | `string(255)`      |
# **`updated_at`**  | `datetime`         |
#

class ShiftType < ActiveRecord::Base
  validates :name, :presence => true, :uniqueness => true

  has_many :shifts, :dependent => :destroy
  
  scope :active,       -> { where(active: true) }
  scope :inactive,     -> { where(active: false) }
end

