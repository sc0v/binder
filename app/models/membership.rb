# ## Schema Information
#
# Table name: `memberships`
#
# ### Columns
#
# Name                     | Type               | Attributes
# ------------------------ | ------------------ | ---------------------------
# **`booth_chair_order`**  | `integer`          |
# **`created_at`**         | `datetime`         |
# **`id`**                 | `integer`          | `not null, primary key`
# **`is_booth_chair`**     | `boolean`          |
# **`organization_id`**    | `integer`          |
# **`participant_id`**     | `integer`          |
# **`title`**              | `string(255)`      |
# **`updated_at`**         | `datetime`         |
#
# ### Indexes
#
# * `index_memberships_on_organization_id`:
#     * **`organization_id`**
# * `index_memberships_on_participant_id`:
#     * **`participant_id`**
#

class Membership < ActiveRecord::Base
  validates_presence_of :participant, :organization
  validates_associated :participant, :organization
  validates_uniqueness_of :participant_id, :scope => :organization_id

  belongs_to :organization
  belongs_to :participant

  scope :booth_chairs, -> { where(:is_booth_chair => true).order('booth_chair_order ASC') }

  def organization_name_formatted
    if is_booth_chair?
      organization.name + " - Booth Chair"
    else
      organization.name
    end
  end
  
end