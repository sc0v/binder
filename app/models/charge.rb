# ## Schema Information
#
# Table name: `charges`
#
# ### Columns
#
# Name                            | Type               | Attributes
# ------------------------------- | ------------------ | ---------------------------
# **`amount`**                    | `decimal(8, 2)`    |
# **`charge_type_id`**            | `integer`          |
# **`charged_at`**                | `datetime`         |
# **`created_at`**                | `datetime`         |
# **`creating_participant_id`**   | `integer`          |
# **`description`**               | `text(65535)`      |
# **`id`**                        | `integer`          | `not null, primary key`
# **`is_approved`**               | `boolean`          |
# **`issuing_participant_id`**    | `integer`          |
# **`organization_id`**           | `integer`          |
# **`receiving_participant_id`**  | `integer`          |
# **`updated_at`**                | `datetime`         |
#
# ### Indexes
#
# * `index_charges_on_organization_id`:
#     * **`organization_id`**
#

class Charge < ActiveRecord::Base
  validates_presence_of :charged_at, :issuing_participant, :organization, :charge_type, :amount
  validates_associated :issuing_participant, :organization, :charge_type, :receiving_participant, :creating_participant
  validates :amount, :numericality => true

  belongs_to :organization
  belongs_to :charge_type
  belongs_to :issuing_participant, :class_name => "Participant"
  belongs_to :receiving_participant, :class_name => "Participant"
  belongs_to :creating_participant, :class_name => "Participant"
  
  default_scope { order('charged_at DESC') }
  scope :approved, -> { where(is_approved: true) }
  scope :pending, -> { where(is_approved: false) }

  def self.for_organizations(organizations)
    if (organizations.nil?)
      all
    else
      where("organization_id IN (?)", organizations)
    end
  end
end

