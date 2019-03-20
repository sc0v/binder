# ## Schema Information
#
# Table name: `tool_types`
#
# ### Columns
#
# Name              | Type               | Attributes
# ----------------- | ------------------ | ---------------------------
# **`created_at`**  | `datetime`         |
# **`id`**          | `integer`          | `not null, primary key`
# **`name`**        | `string(255)`      |
# **`updated_at`**  | `datetime`         |
#

class ToolType < ActiveRecord::Base
  has_many :tools
  has_many :certs, :through => :tool_type_certifications, source: :tool_type
  has_many :tool_type_certifications, dependent: :destroy
  validates :name, presence: true, uniqueness: true

  default_scope {order(:name)}
end
