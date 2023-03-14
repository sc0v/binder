# frozen_string_literal: true

class Participant < ApplicationRecord
  before_save :reformat_phone

  validates :eppn, presence: true, uniqueness: true
  # validates :has_signed_waiver, :acceptance => {:accept => true}
  validates :phone_number, format: { with: /\A\(?\d{3}\)?[-. ]?\d{3}[-.]?\d{4}\Z/,
                                     message: 'should be 10 digits (area code needed) and delimited with dashes only', allow_blank: true }

  has_many :memberships, dependent: :destroy
  has_many :organizations, through: :memberships
  has_many :shift_participants, dependent: :destroy
  has_many :shifts, through: :shift_participants
  has_many :certs, through: :certifications, source: :participant
  has_many :checkouts, dependent: :destroy
  has_many :tools, through: :checkouts
  has_many :certifications, dependent: :destroy
  has_many :organization_statuses, dependent: :destroy
  has_many :events

  default_scope { order('eppn') }
  scope :search, lambda { |term|
                   where('lower(eppn) LIKE lower(?) OR lower(cached_name) LIKE lower(?)', "%#{term}%", "%#{term}%")
                 }
  scope :scc, -> { joins(:organizations).where(organizations: { name: 'Spring Carnival Committee' }).group(:id) }
  scope :exec, lambda {
                 joins(:organizations).where(organizations: { name: 'Spring Carnival Committee' }).joins(:memberships).where(memberships: { is_booth_chair: true }).group(:id)
               }
  scope :active,       -> { where(active: true) }
  scope :inactive,     -> { where(active: false) }

  def start_waiver_timer
    self.waiver_start = DateTime.now
    save
  end

  def is_waiver_cheater?
    (waiver_start + 3.minutes) > DateTime.now
  end

  def is_booth_chair?
    memberships.booth_chairs.present?
  end

  def booth_chair_organizations
    memberships.booth_chairs.map(&:organization).select do |org|
      org.organization_category.building
    end
  end

  def scc?
    organizations.find_by(name: 'Spring Carnival Committee').present?
  end

  attr_accessor :card_number

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

  # error handling here does not work?
  class NotRegistered < StandardError
  end

  # Initialize a user based on auth info from an Omniauth strategy
  def self.from_omniauth(auth_info)
    Rails.logger.debug auth_info
    return if (eppn = auth_info['uid']).blank?

    find_or_create_by!(eppn:)
  end

  def self.find_by_card(card_number, lookup_only = false)
    return nil if card_number.blank?

    person = find_by(eppn: card_number)

    if person.present?
      person # self.find_by_andrewid(card_number)
    elsif !lookup_only && CarnegieMellonPerson.find_by(eppn: card_number.downcase).present?
      find_or_create_by(eppn: card_number.downcase)
    # Decimal CSN from MIFARE reader (10 decimal digits)
    elsif card_number[/\A\d{10}\z/]
      # Must pad to 8 hex digits for the card translation service
      andrewid = CarnegieMellonIDCard.get_andrewid_by_card_csn(card_number.to_i.to_s(16).rjust(8, '0'))
      eppn = "#{andrewid}@andrew.cmu.edu"
      return find_or_create_by(eppn:) if andrewid.present?
    # PIK number from magstripe or printed on card (9 decimal digits, allow leading % character and trailing data)
    elsif card_number[/^%?\d{9}/]
      andrewid = CarnegieMellonIDCard.get_andrewid_by_card_id(card_number)
      eppn = "#{andrewid}@andrew.cmu.edu"
      return find_or_create_by(eppn:) if andrewid.present?
    # Hexadecimal CSN from MIFARE reader (8 hex digits)
    elsif card_number[/\A[0-9a-fA-F]{8}\z/]
      andrewid = CarnegieMellonIDCard.get_andrewid_by_card_csn(card_number)
      eppn = "#{andrewid}@andrew.cmu.edu"
      return find_or_create_by(eppn:) if andrewid.present?
    end
  end

  def self.search_ldap(uid = '')
    return if CarnegieMellonPerson.find_by(uid: uid.downcase).blank?

    Participant.new({ eppn: "#{uid.downcase}@andrew.cmu.edu" })
  end

  def formatted_phone_number
    return 'N/A' if phone_number.blank?

    ActionController::Base.helpers.number_to_phone(phone_number, area_code: true)
  end

  def formatted_name
    "#{name} (#{eppn})"
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
    return unless self[:cache_updated].nil? || DateTime.now - 14.days > self[:cache_updated]

    ldap_reference ||= CarnegieMellonPerson.find_by(eppn:)

    if ldap_reference.nil?
      self[:cached_name] = 'N/A'
      self[:cached_surname] = 'N/A'
      self[:cached_email] = (eppn.presence || 'N/A')
      self[:cached_department] = 'N/A'
      self[:cached_student_class] = 'N/A'
    else
      self[:cached_name] = Array.[](ldap_reference['cn']).flatten.last
      self[:cached_surname] = ldap_reference['sn']
      self[:cached_email] = ldap_reference['mail']
      self[:cached_department] = ldap_reference['cmuDepartment']
      self[:cached_student_class] = ldap_reference['cmuStudentClass']
    end

    self[:cache_updated] = DateTime.now
    save! unless id.blank? || readonly?
  end

  def reformat_phone
    return if phone_number.blank?

    phone_number = self.phone_number.to_s
    phone_number.gsub!(/[^0-9]/, '')
    self.phone_number = phone_number
  end
end
