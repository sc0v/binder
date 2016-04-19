# ## Schema Information
#
# Table name: `shifts`
#
# ### Columns
#
# Name                                   | Type               | Attributes
# -------------------------------------- | ------------------ | ---------------------------
# **`created_at`**                       | `datetime`         |
# **`description`**                      | `string(255)`      |
# **`ends_at`**                          | `datetime`         |
# **`id`**                               | `integer`          | `not null, primary key`
# **`organization_id`**                  | `integer`          |
# **`required_number_of_participants`**  | `integer`          |
# **`shift_type_id`**                    | `integer`          |
# **`starts_at`**                        | `datetime`         |
# **`updated_at`**                       | `datetime`         |
#
# ### Indexes
#
# * `index_shifts_on_organization_id`:
#     * **`organization_id`**
#

class Shift < ActiveRecord::Base
  validates_presence_of :starts_at, :ends_at, :required_number_of_participants, :shift_type
  validates_associated :organization, :shift_type

  belongs_to :organization
  belongs_to :shift_type

  has_many :participants, :through => :shift_participants
  has_many :shift_participants, :dependent => :destroy

  default_scope { order('starts_at asc') }
  scope :current, lambda { where("starts_at < ? and ends_at > ?", Time.zone.now, Time.zone.now ) }
  scope :future, lambda { where("starts_at > ?", Time.zone.now ) }
  scope :upcoming, lambda { where("starts_at > ? and starts_at < ?", Time.zone.now, Time.zone.now + 4.hours ) }
  scope :past, lambda { where("ends_at < ?", Time.zone.now) }
  scope :missed, lambda { where("required_number_of_participants > (
                                    SELECT COUNT(*)
                                    FROM shift_participants
                                    WHERE shift_participants.shift_id = shifts.id)")}

  #scopes for each type of shift, selected by their shift_type ID
  scope :watch_shifts, -> { where('shift_type_id = ?', 1) }
  scope :sec_shifts, -> { where('shift_type_id = ?', 2) }
  scope :coord_shifts, -> { where('shift_type_id = ?', 3) }

  def formatted_name
    if organization.blank?
      shift_type.name + " @ " + starts_at.strftime("%b %e at %l:%M %p")
    else
      shift_type.name + " @ " + starts_at.strftime("%b %e at %l:%M %p") + ' - ' +  organization.name
    end
  end

  def is_checked_in
    return participants.size == required_number_of_participants
  end
end

