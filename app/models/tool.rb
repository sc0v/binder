# ## Schema Information
#
# Table name: `tools`
#
# ### Columns
#
# Name                | Type               | Attributes
# ------------------- | ------------------ | ---------------------------
# **`barcode`**       | `integer`          |
# **`created_at`**    | `datetime`         |
# **`description`**   | `text`             |
# **`id`**            | `integer`          | `not null, primary key`
# **`tool_type_id`**  | `integer`          |
# **`updated_at`**    | `datetime`         |
#
# ### Indexes
#
# * `index_tools_on_barcode`:
#     * **`barcode`**
# * `index_tools_on_tool_type_id`:
#     * **`tool_type_id`**
#

class Tool < ActiveRecord::Base
  has_many :checkouts, dependent: :destroy
  has_many :participants, :through => :checkouts
  has_many :organizations, :through => :checkouts
  belongs_to :tool_type

  validates :barcode, :presence => true, :uniqueness => true, :length => { :minimum => 1, :maximum => 5}
  validates_presence_of :tool_type_id
  validates_associated :tool_type

  default_scope { order('barcode') }
  scope :by_barcode, -> { order('barcode') }
  scope :by_type, ->(type){ where(tool_type: type) }
  scope :hardhats, -> { joins(:tool_type).where("lower(name) LIKE lower(?)", "%hardhat") }
  scope :radios, -> { joins(:tool_type).where("lower(name) LIKE lower(?)", "%radio") }
  scope :just_tools, -> { joins(:tool_type).where("lower(name) NOT LIKE lower(?) AND lower(name) NOT LIKE lower(?)", "%radio", "%hardhat") }
  scope :search, lambda { |term| joins(:tool_type).where("lower(name) LIKE lower(?) OR CAST(barcode AS CHAR) LIKE lower(?) OR lower(description) LIKE lower(?)", "%#{term}%", "%#{term}%", "%#{term}%") }
  scope :checked_out, -> { joins(:checkouts).where(checkouts: {checked_in_at: nil}) }
  scope :checked_in, -> { where('tools.id NOT IN (SELECT checkouts.tool_id FROM checkouts WHERE checked_in_at IS NULL)') }

  def current_organization
    self.checkouts.current.take.organization unless self.checkouts.current.blank?
  end

  def current_participant
    self.checkouts.current.take.participant unless self.checkouts.current.blank?
  end

  def is_checked_out?
    return not(self.checkouts.current.empty?)
  end

  def is_waitlist_critical?
    num_on_waitlist = ToolWaitlist.for_tool_type(self.tool_type).count
    num_available = Tool.by_type(self.tool_type).checked_in.count
    return num_on_waitlist > 0 && num_on_waitlist >= num_available
  end

  def is_hardhat?
    return self.name.downcase.include?('hardhat')
  end

  def self.checked_out_by_organization(organization)
    joins(:checkouts).where(:checkouts => {:organization_id => organization, :checked_in_at => nil })
  end

  def name
    self.tool_type.name
  end

  def formatted_name
    unless description.blank?
		  return "#{barcode}: " + name + " - " + description
    else
      return "#{barcode}: " + name
    end
  end
end

