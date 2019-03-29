# ## Schema Information
#
# Table name: `certifications`
#
# ### Columns
#
# Name                         | Type               | Attributes
# ---------------------------- | ------------------ | ---------------------------
# **`active`**                 | `boolean`          | `default(TRUE)`
# **`certification_type_id`**  | `integer`          |
# **`created_at`**             | `datetime`         | `not null`
# **`id`**                     | `integer`          | `not null, primary key`
# **`participant_id`**         | `integer`          |
# **`updated_at`**             | `datetime`         | `not null`
#
# ### Indexes
#
# * `index_certifications_on_certification_type_id`:
#     * **`certification_type_id`**
# * `index_certifications_on_participant_id`:
#     * **`participant_id`**
#

class Certification < ActiveRecord::Base
  belongs_to :certification_type
  belongs_to :participant
  
  scope :active,       -> { where(active: true) }
  scope :inactive,     -> { where(active: false) }
end
