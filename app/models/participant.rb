# ## Schema Information
#
# Table name: `participants`
#
# ### Columns
#
# Name                             | Type               | Attributes
# -------------------------------- | ------------------ | ---------------------------
# **`andrewid`**                   | `string(255)`      |
# **`cache_updated`**              | `datetime`         |
# **`cached_department`**          | `string(255)`      |
# **`cached_email`**               | `string(255)`      |
# **`cached_name`**                | `string(255)`      |
# **`cached_student_class`**       | `string(255)`      |
# **`cached_surname`**             | `string(255)`      |
# **`created_at`**                 | `datetime`         |
# **`has_signed_hardhat_waiver`**  | `boolean`          |
# **`has_signed_waiver`**          | `boolean`          |
# **`id`**                         | `integer`          | `not null, primary key`
# **`phone_carrier_id`**           | `integer`          |
# **`phone_number`**               | `string(255)`      |
# **`updated_at`**                 | `datetime`         |
# **`user_id`**                    | `integer`          |
#
# ### Indexes
#
# * `index_participants_on_phone_carrier_id`:
#     * **`phone_carrier_id`**
#

class Participant < ActiveRecord::Base
  before_save :reformat_phone
  
  validates :andrewid, :presence => true, :uniqueness => true
  # validates :has_signed_waiver, :acceptance => {:accept => true}
  validates_format_of :phone_number, :with => /\A\(?\d{3}\)?[-. ]?\d{3}[-.]?\d{4}\Z/, :message => "should be 10 digits (area code needed) and delimited with dashes only", :allow_blank => true

  has_many :organizations, :through => :memberships
  has_many :shifts, :through => :shift_participants
  has_many :checkouts, dependent: :destroy
  has_many :tools, :through => :checkouts
  has_many :memberships, dependent: :destroy
  has_many :shift_participants, dependent: :destroy
  has_many :organization_statuses, dependent: :destroy
  has_many :events
  belongs_to :phone_carrier
  belongs_to :user, dependent: :destroy


  default_scope { order('andrewid') }
  scope :search, lambda { |term| where('lower(andrewid) LIKE lower(?) OR lower(cached_name) LIKE lower(?)', "%#{term}%", "%#{term}%") }
  scope :scc, -> { joins(:organizations).where(organizations: {name: 'Spring Carnival Committee'}) }
  scope :exec, -> { joins(:organizations).where(organizations: {name: 'Spring Carnival Committee'}).joins(:memberships).where(memberships: {is_booth_chair: true}) }

  def is_booth_chair?
    !memberships.booth_chairs.blank?
  end

  def is_scc?
    !organizations.find_by(name: "Spring Carnival Committee").blank?
  end

  def card_number=( card_number )
    @card_number = card_number
  end

  def card_number
    @card_number
  end
  
  def name
    cached_name
  end

  def surname
    cached_surname
  end

  def email
    cached_email
  end

  def department
    cached_department
  end

  def student_class
    cached_student_class
  end

  #error handling here does not work?
  class NotRegistered < Exception
  end

  def self.find_by_card(card_number, lookup_only = false)
    return nil if card_number.blank?

    person = self.find_by_andrewid(card_number)

    if !person.blank?
      return person #self.find_by_andrewid(card_number)
    elsif !lookup_only and !CarnegieMellonPerson.find_by_andrewid(card_number.downcase).blank?
      return self.find_or_create_by(andrewid: card_number.downcase)
    elsif card_number[/^%?\d{9}/]
      andrewid = CarnegieMellonIDCard.get_andrewid_by_card_id(card_number)
      return self.find_or_create_by(andrewid: andrewid) unless andrewid.blank?
    elsif card_number[/^[0-9a-fA-F]{8}/]
      andrewid = CarnegieMellonIDCard.get_andrewid_by_card_csn(card_number)
      return self.find_or_create_by(andrewid: andrewid) unless andrewid.blank?
    end
  end

  def self.search_ldap(andrewid = '')
    Participant.new({andrewid: andrewid.downcase}) unless CarnegieMellonPerson.find_by_andrewid(andrewid.downcase).blank?
  end

  def formatted_phone_number
    if phone_number.blank?
      return "N/A"
    else
      ActionController::Base.helpers.number_to_phone(phone_number, area_code: true)
    end
  end

  def formatted_name
    name  + " (" + andrewid + ")"
  end
  
  private
  
  def self.get_andrewid_by_card_id(card_number)
    CarnegieMellonIDCard.search(card_number)
  end

  def self.get_andrewid_by_card_csn(card_number)
    CarnegieMellonIDCard.search_card_id(card_number)
  end

  def cached_name
    update_cache
    
    read_attribute(:cached_name)
  end
  
  def cached_surname
    update_cache
    
    read_attribute(:cached_surname)
  end
  
  def cached_email
    update_cache
    
    read_attribute(:cached_email)
  end
  
  def cached_department
    update_cache
    
    read_attribute(:cached_department)
  end
  
  def cached_student_class
    update_cache
    
    read_attribute(:cached_student_class)
  end
  
  def cache_updated
    update_cache
    
    read_attribute(:cache_updated)
  end
  
  def update_cache
    if read_attribute(:cache_updated).nil? || DateTime.now - 14.days > read_attribute(:cache_updated)
      ldap_reference ||= CarnegieMellonPerson.find_by_andrewid( self.andrewid )
      
      if !ldap_reference.nil?
        write_attribute :cached_name, Array.[](ldap_reference["cn"]).flatten.last
        write_attribute :cached_surname, ldap_reference["sn"]
        write_attribute :cached_email, ldap_reference["mail"]
        write_attribute :cached_department, ldap_reference["cmuDepartment"]
        write_attribute :cached_student_class, ldap_reference["cmuStudentClass"]
      else
        write_attribute :cached_name, "N/A"
        write_attribute :cached_surname, "N/A"
        write_attribute :cached_email, andrewid + "@andrew.cmu.edu"
        write_attribute :cached_department, "N/A"
        write_attribute :cached_student_class, "N/A"
      end

      write_attribute :cache_updated, DateTime.now
      self.save! unless self.id.blank? or self.readonly?
    end
  end
  
  def reformat_phone
    phone_number = self.phone_number.to_s
    phone_number.gsub!(/[^0-9]/,"")
    self.phone_number = phone_number
  end

end