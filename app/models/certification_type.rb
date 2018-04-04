# ## Schema Information
#
# Table name: `certification_types`
#
# ### Columns
#
# Name              | Type               | Attributes
# ----------------- | ------------------ | ---------------------------
# **`created_at`**  | `datetime`         | `not null`
# **`id`**          | `integer`          | `not null, primary key`
# **`name`**        | `string`           |
# **`updated_at`**  | `datetime`         | `not null`
#

class CertificationType < ActiveRecord::Base
  validates :name, :presence => true, :uniqueness => true
end
