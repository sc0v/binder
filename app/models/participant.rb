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
  validates :name, confirmation: { case_sensitive: false }, on: :waiver_signing
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
              message: :format,
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
           inverse_of: :participant,
           dependent: :destroy
  has_many :organizations, through: :memberships
  has_many :organization_categories, through: :organizations
  has_many :organization_build_steps, dependent: :restrict_with_error
  has_many :certifications, dependent: :destroy
  has_many :certification_types, through: :certifications

  has_many :shift_participants, dependent: :destroy
  has_many :shifts, through: :shift_participants
  has_many :checkouts, dependent: :destroy
  has_many :tools, through: :checkouts

  has_many :events, dependent: :nullify

  def link
    participant_path(self)
  end

  # scope :search,
  #      lambda { |term|
  #        where(
  #          'lower(eppn) LIKE lower(?) OR lower(cached_name) LIKE lower(?)',
  #          "%#{term}%",
  #          "%#{term}%"
  #        )
  #      }

  def self.find_by(*)
    # puts args
    # if args.first.keys.include?(:search)
    #  search(args)
    # elsif args.first.keys.include?(:card)
    #  find_by_card(*args)
    # else
    super
    # end
  end

  def self.search(search)
    @participant =
      Participant.find_by(eppn: search.to_s) ||
        Participant.find_by(eppn: "#{search}@andrew.cmu.edu") ||
        Participant.find_by(card: search.to_s)
  end

  def self.find_or_create_by_search(search)
    @participant = Participant.search(search.to_s)
    # TODO: creation
  end

  scope :scc,
        lambda {
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

  scope :in_organization,
        lambda { |organization_id|
          joins(:organizations).where(
            organizations: {
              id: organization_id
            }
          ).group(:id)
        }

  scope :active, -> { where(active: true) }
  scope :inactive, -> { where(active: false) }

  def self.find_by_query(input)
    participant = search(input)
    return participant if participant.present?

    return if input.to_s.strip.length < 3

    participant =
      where(
        'lower(eppn) = lower(?) OR lower(cached_email) = lower(?)',
        input,
        input
      ).first
    return participant if participant.present?

    where('lower(cached_name) LIKE lower(?)', "%#{input}%").first
  end

  def booth_chair?
    memberships.booth_chairs.present?
  end

  def red_hardhat?
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

  def self.find_by_card(card_number, lookup_only: false)
    return nil if card_number.blank?

    person = find_by(eppn: card_number)
    return person if person

    if lookup_only
      participant_from_card_format(card_number)
    else
      participant_from_ldap_card(card_number)
    end
  rescue StandardError => e
    Rails.logger.warn("Participant.find_by_card: #{e.message}")
    nil
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

    buildings = organization_categories.pluck(:building)
    cert_names = certification_types.pluck(:name)
    [].tap do |bands|
      bands << :blue if buildings.include?(false)
      bands << :red if buildings.include?(true)
      bands << :green if cert_names.include?('Scissor Lift')
    end
  end

  def scissor_lift_certified?
    wristbands.present? && wristbands.include?(:green)
  end

  def hardhat_color
    return unless signed_waiver?
    return if organization_categories.blank?
    return if organization_categories.pluck(:lookup_key).uniq == ['doghouse']
    return :blue if scc?
    return :red if booth_chair? && red_hardhat?

    :white
  end

  def self.table_attrs
    joins(
      'LEFT OUTER JOIN memberships AS m ON m.participant_id = participants.id AND m.is_booth_chair = TRUE'
    ).select(
      'participants.*,
      m.is_booth_chair AS is_booth_chair'
    )
  end

  private

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
    return if cache_current?

    ldap_reference = CarnegieMellonPerson.find_by(eppn:)
    apply_cache(ldap_reference)
    self[:cache_updated] = DateTime.now
    save!(validate: false) unless id.blank? || readonly?
  end

  def cache_current?
    !self[:cache_updated].nil? && DateTime.now - 14.days <= self[:cache_updated]
  end

  def apply_cache(ldap_reference)
    ldap_reference ? apply_ldap_cache(ldap_reference) : apply_na_cache
  end

  def apply_ldap_cache(ref)
    self[:cached_name] = Array(ref['cn']).flatten.last
    self[:cached_surname] = ref['sn']
    self[:cached_email] = ref['mail']
    self[:cached_department] = ref['cmuDepartment']
    self[:cached_student_class] = ref['cmuStudentClass']
  end

  def apply_na_cache
    self[:cached_name] = 'N/A'
    self[:cached_surname] = 'N/A'
    self[:cached_email] = eppn.presence || 'N/A'
    self[:cached_department] = 'N/A'
    self[:cached_student_class] = 'N/A'
  end

  def reformat_phone
    return if phone_number.blank?

    phone_number = self.phone_number.to_s
    phone_number.gsub!(/[^0-9]/, '')
    self.phone_number = phone_number
  end

  class << self
    private

    def participant_from_ldap_card(card_number)
      if CarnegieMellonPerson.find_by(eppn: card_number.downcase).present?
        find_or_create_by(eppn: card_number.downcase)
      else
        participant_from_card_format(card_number)
      end
    end

    def participant_from_card_format(card_number)
      # Decimal CSN from MIFARE reader (10 decimal digits)
      if card_number[/\A\d{10}\z/]
        # Must pad to 8 hex digits for the card translation service
        csn = card_number.to_i.to_s(16).rjust(8, '0') # stree-ignore
        andrewid_to_participant(
          CarnegieMellonIdCard.get_andrewid_by_card_csn(csn)
        )
        # PIK number from magstripe or printed on card (9 decimal digits, allow leading % and trailing data)
      elsif card_number[/^%?\d{9}/]
        andrewid_to_participant(
          CarnegieMellonIdCard.get_andrewid_by_card_id(card_number)
        )
        # Hexadecimal CSN from MIFARE reader (8 hex digits)
      elsif card_number[/\A[0-9a-fA-F]{8}\z/]
        andrewid_to_participant(
          CarnegieMellonIdCard.get_andrewid_by_card_csn(card_number)
        )
      end
    end

    def andrewid_to_participant(andrewid)
      eppn = "#{andrewid}@andrew.cmu.edu"
      find_or_create_by(eppn:) if andrewid.present?
    end
  end
end
