# ## Schema Information
#
# Table name: `charge_types`
#
# ### Columns
#
# Name                                 | Type               | Attributes
# ------------------------------------ | ------------------ | ---------------------------
# **`created_at`**                     | `datetime`         |
# **`default_amount`**                 | `decimal(8, 2)`    |
# **`description`**                    | `text(65535)`      |
# **`id`**                             | `integer`          | `not null, primary key`
# **`name`**                           | `string(255)`      |
# **`requires_booth_chair_approval`**  | `boolean`          |
# **`updated_at`**                     | `datetime`         |
#

class ChargeType < ActiveRecord::Base
  # attr_accessible :default_amount, :default_amount, :description, :name, :requires_booth_chair_approval  

  validates :name, :presence => true, :uniqueness => true

  has_many :charges, dependent: :destroy
  
end
