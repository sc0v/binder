# ## Schema Information
#
# Table name: `checkouts`
#
# ### Columns
#
# Name                   | Type               | Attributes
# ---------------------- | ------------------ | ---------------------------
# **`checked_in_at`**    | `datetime`         |
# **`checked_out_at`**   | `datetime`         |
# **`created_at`**       | `datetime`         |
# **`id`**               | `integer`          | `not null, primary key`
# **`organization_id`**  | `integer`          |
# **`participant_id`**   | `integer`          |
# **`tool_id`**          | `integer`          |
# **`updated_at`**       | `datetime`         |
#
# ### Indexes
#
# * `index_checkouts_on_tool_id`:
#     * **`tool_id`**
#

class Checkout < ActiveRecord::Base
  # For lookups
  def card_number=( card_number )
    @card_number = card_number
  end

  def card_number
    @card_number
  end

  validates_presence_of :tool, :organization
  validates_associated :tool, :organization, :participant

  before_save :checked_out_at, :presence => true

  belongs_to :participant
  belongs_to :organization
  belongs_to :tool

  default_scope { order('tool_id ASC, checked_out_at DESC') }
  scope :old, -> { where('checked_in_at IS NOT NULL') }
  scope :current, -> { where('checked_in_at IS NULL') }

end
