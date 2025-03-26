# frozen_string_literal: true
class Participant < ApplicationRecord
  include Rails.application.routes.url_helpers

  # Safety briefing
  validates :safety_briefing_expected_end_at,
            presence: true,
            on: :safety_briefing
  validates :safety_briefing_expected_end_at,
            comparison: {
              less_than: proc { Time.zone.now }
            },
            on: :safety_briefing
  validates :watched_safety_video, acceptance: true, on: :safety_briefing

  # Waiver
  validates :adult, acceptance: true, on: :waiver_signing
  validates :name, confirmation: {case_sensitive: false}, on: :waiver_signing
  validates :name_confirmation, presence: true, on: :waiver_signing
  validates :signed_waiver, acceptance: true, on: :waiver_signing

  before_validation :trim_name_confirmation

  def trim_name_confirmation
    self.name_confirmation = name_confirmation.strip if name_confirmation
  end

  # General Attributes
  validates :eppn, presence: true, uniqueness: true
  validates :phone_number,
            presence: true,
            # Don't validate phone_number in the :safety_briefing context (no form until waiver)
            unless: -> { id.blank? || safety_briefing_expected_end_at.present? }
  validates :phone_number,
            format: {
              with: /\A\(?\d{3}\)?[-. ]?\d{3}[-.]?\d{4}\Z/,
              message:
                'should be 10 digits (area code needed) and separated by dashes only',
              allow_blank: true
            }
  before_save :reformat_phone

  delegate :can?, :cannot?, to: :ability
  def ability
    @ability ||= Ability.new(self)
  end
  scope :ordered_by_name, -> { order(eppn: :asc) }

  has_many :memberships,
           -> { includes(organization: :organization_category) },
           dependent: :destroy
  has_many :organizations, through: :memberships
  has_many :organization_categories, through: :organizations
  has_many :organization_build_steps
  has_many :certifications, dependent: :destroy
  has_many :certification_types, through: :certifications

  has_many :shift_participants, dependent: :destroy
  has_many :shifts, through: :shift_participants
  has_many :checkouts, dependent: :destroy
  has_many :tools, through: :checkouts

  has_many :events

  def link
    participant_path(self)
  end

  #scope :search,
  #      lambda { |term|
  #        where(
  #          'lower(eppn) LIKE lower(?) OR lower(cached_name) LIKE lower(?)',
  #          "%#{term}%",
  #          "%#{term}%"
  #        )
  #      }

  def self.find_by(*args)
    #puts args
    #if args.first.keys.include?(:search)
    #  find_by_search(args)
    #elsif args.first.keys.include?(:card)
    #  find_by_card(*args)
    #else
      super(*args)
    #end
  end

  def self.find_by_search(search)
    @participant = Participant.find_by(eppn: search.to_s) ||
                   Participant.find_by(eppn: "#{search}@andrew.cmu.edu") ||
                   Participant.find_by_card(search.to_s)
  end

  def self.find_or_create_by_search(search)
    @participant = Participant.find_by_search(search.to_s)
    # TODO: creation
  end

  scope :scc,
        -> {
          joins(:organizations).where(
            organizations: {
              name: 'Spring Carnival Committee'
            }
          ).group(:id)
        }
  scope :exec,
        lambda {
          joins(:organizations)
            .where(organizations: { name: 'Spring Carnival Committee' })
            .joins(:memberships)
            .where(memberships: { is_booth_chair: true })
            .group(:id)
        }

  scope :in_organization, ->(organization_id) {
    joins(:organizations)
      .where(organizations: { id: organization_id})
      .group(:id)
  }

  scope :active, -> { where(active: true) }
  scope :inactive, -> { where(active: false) }

  def is_booth_chair?
    memberships.booth_chairs.present?
  end

  def is_red_hardhat?
    memberships.where(is_red_hardhat: true).present?
  end

  def booth_chair_organizations
    memberships
      .booth_chairs
      .map(&:organization)
      .select { |org| org.organization_category.building }
  end

  def scc?
    organizations.find_by(name: 'Spring Carnival Committee').present?
  end

  attr_accessor :card_number,
                :adult,
                :waiver_signature,
                :safety_briefing_expected_end_at
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
    elsif !lookup_only &&
          CarnegieMellonPerson.find_by(eppn: card_number.downcase).present?
      find_or_create_by(eppn: card_number.downcase)
      # Decimal CSN from MIFARE reader (10 decimal digits)
    elsif card_number[/\A\d{10}\z/]
      # Must pad to 8 hex digits for the card translation service
      andrewid =
        CarnegieMellonIdCard.get_andrewid_by_card_csn(
          card_number.to_i.to_s(16).rjust(8, '0')
        )
      eppn = "#{andrewid}@andrew.cmu.edu"
      return find_or_create_by(eppn:) if andrewid.present? # stree-ignore
      # PIK number from magstripe or printed on card (9 decimal digits, allow leading % character and trailing data)
    elsif card_number[/^%?\d{9}/]
      andrewid = CarnegieMellonIdCard.get_andrewid_by_card_id(card_number)
      eppn = "#{andrewid}@andrew.cmu.edu"
      return find_or_create_by(eppn:) if andrewid.present?
      # Hexadecimal CSN from MIFARE reader (8 hex digits)
    elsif card_number[/\A[0-9a-fA-F]{8}\z/]
      andrewid = CarnegieMellonIdCard.get_andrewid_by_card_csn(card_number)
      eppn = "#{andrewid}@andrew.cmu.edu"
      return find_or_create_by(eppn:) if andrewid.present?
    end
  rescue
  end

  def self.search_ldap(uid = '')
    return if CarnegieMellonPerson.find_by(uid: uid.downcase).blank?

    Participant.new({ eppn: "#{uid.downcase}@andrew.cmu.edu" })
  end

  def formatted_phone_number
    return 'N/A' if phone_number.blank?

    ActionController::Base.helpers.number_to_phone(
      phone_number,
      area_code: true
    )
  end

  def formatted_name
    "#{name} (#{eppn})"
  end

  def wristbands
    return unless signed_waiver?
    return if organization_categories.blank?
    return [:yellow] if alumni
    if organization_categories.pluck(:building).include? true
      return [:green] if certification_types.pluck(:name).include? 'Scissor Lift'
      [:red]
    else
      return [:green, :blue] if certification_types.pluck(:name).include? 'Scissor Lift'
      [:blue]
    end
  end

  def hardhat_color
    return unless signed_waiver?
    return if organization_categories.blank?
    return if organization_categories.pluck(:lookup_key).uniq == ['doghouse']
    return :blue if scc?
    return :red if is_booth_chair? && is_red_hardhat?
    :white
  end

  def self.table_attrs
    joins("LEFT OUTER JOIN memberships AS m ON m.participant_id = participants.id AND m.is_booth_chair = TRUE")
    .select(
      'participants.*,
      m.is_booth_chair AS is_booth_chair'
    )
  end
  private

  def self.get_andrewid_by_card_id(card_number)
    CarnegieMellonIdCard.search(card_number)
  end

  def self.get_andrewid_by_card_csn(card_number)
    CarnegieMellonIdCard.search_card_id(card_number)
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
    unless self[:cache_updated].nil? ||
           DateTime.now - 14.days > self[:cache_updated]
      return
    end

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
    save!(validate: false) unless id.blank? || readonly?
  end

  def reformat_phone
    return if phone_number.blank?

    phone_number = self.phone_number.to_s
    phone_number.gsub!(/[^0-9]/, '')
    self.phone_number = phone_number
  end
end
