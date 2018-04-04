# ## Schema Information
#
# Table name: `shift_types`
#
# ### Columns
#
# Name              | Type               | Attributes
# ----------------- | ------------------ | ---------------------------
# **`created_at`**  | `datetime`         |
# **`id`**          | `integer`          | `not null, primary key`
# **`name`**        | `string`           |
# **`short_name`**  | `string`           |
# **`updated_at`**  | `datetime`         |
#

class ShiftType < ActiveRecord::Base
  validates :name, :presence => true, :uniqueness => true

  has_many :shifts, :dependent => :destroy
end

