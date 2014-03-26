# ## Schema Information
#
# Table name: `tools`
#
# ### Columns
#
# Name               | Type               | Attributes
# ------------------ | ------------------ | ---------------------------
# **`barcode`**      | `integer`          |
# **`created_at`**   | `datetime`         |
# **`description`**  | `text`             |
# **`id`**           | `integer`          | `not null, primary key`
# **`name`**         | `string(255)`      | `not null`
# **`updated_at`**   | `datetime`         |
#
# ### Indexes
#
# * `index_tools_on_barcode`:
#     * **`barcode`**
#

class Tool < ActiveRecord::Base
  has_many :checkouts, dependent: :destroy
  has_many :participants, :through => :checkouts
  has_many :organizations, :through => :checkouts

  validates :barcode, :presence => true, :uniqueness => true, :length => { :minimum => 1, :maximum => 5}
  validates :name, :presence => true

  default_scope { order('barcode') }
  scope :by_barcode, -> { order('barcode') }

  scope :hardhats, -> { where("lower(name) LIKE lower(?)", "%hardhat") }
  scope :radios, -> { where("lower(NAME) LIKE lower(?)", "%radio") }
  scope :just_tools, -> { where("lower(NAME) NOT LIKE lower(?) AND lower(NAME) NOT LIKE lower(?)", "%radio", "%hardhat") }
  scope :search, lambda { |term| where("lower(name) LIKE lower(?) OR CAST(barcode AS CHAR) LIKE lower(?) OR lower(description) LIKE lower(?)", "%#{term}%", "%#{term}%", "%#{term}%") }
  scope :checked_out, -> { Tool.joins(:checkouts).where(checkouts: {checked_in_at: nil}) }


  def current_organization
    self.checkouts.current.take.organization unless self.checkouts.current.blank?
  end

  def current_participant
    self.checkouts.current.take.participant unless self.checkouts.current.blank?
  end

  def is_checked_out?
    return not(self.checkouts.current.empty?)
  end
  
  def is_hardhat?
    return self.name.downcase.include?('hardhat') 
  end

  def self.checked_out_by_organization(organization)
    joins(:checkouts).where(:checkouts => {:organization_id => organization, :checked_in_at => nil })
  end

  def formatted_name
    unless description.blank?
		  return "#{barcode}: " + name + " - " + description
    else
      return "#{barcode}: " + name
    end
  end
end

