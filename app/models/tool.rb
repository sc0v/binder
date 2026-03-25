# frozen_string_literal: true

class Tool < ApplicationRecord
  include Rails.application.routes.url_helpers
  extend ToolTableAttrs

  has_many :checkouts, dependent: :destroy
  has_many :participants, through: :checkouts
  has_many :organizations, through: :checkouts
  belongs_to :tool_type

  validates :barcode,
            presence: true,
            uniqueness: true,
            length: {
              minimum: 1,
              maximum: 5
            }
  validates_associated :tool_type

  default_scope { order(:barcode) }
  scope :by_barcode, -> { order(:barcode) }
  scope :by_type, ->(type) { where(tool_type: type) }
  scope :hardhats,
        -> { joins(:tool_type).where('lower(name) LIKE lower(?)', '%hardhat') }
  scope :radios,
        -> { joins(:tool_type).where('lower(name) LIKE lower(?)', '%radio') }
  scope :just_tools,
        lambda {
          joins(:tool_type).where(
            'lower(name) NOT LIKE lower(?) AND lower(name) NOT LIKE lower(?)',
            '%radio',
            '%hardhat'
          )
        }
  scope :search,
        lambda { |term|
          joins(:tool_type).where(
            'lower(name) LIKE lower(?) OR CAST(barcode AS CHAR) LIKE lower(?) OR lower(description) LIKE lower(?)',
            "%#{term}%",
            "%#{term}%",
            "%#{term}%"
          )
        }
  scope :checked_out,
        -> { joins(:checkouts).where(checkouts: { checked_in_at: nil }) }
  scope :checked_in,
        lambda {
          where(
            'tools.id NOT IN (SELECT checkouts.tool_id FROM checkouts WHERE checked_in_at IS NULL)'
          )
        }
  scope :active, -> { where(active: true) }
  scope :inactive, -> { where(active: false) }
  scope :ordered_by_name, -> { order(name: :asc) }

  scope :damaged, -> { where(status: 'Damaged') }
  scope :late, -> { where(status: 'Late Return') }
  scope :unreturned, -> { where(status: 'Unreturned') }
  def current_organization
    checkouts.current.take.organization if checkouts.current.present?
  end

  def current_participant
    checkouts.current.take.participant if checkouts.current.present?
  end

  def checked_out?
    !checkouts.current.empty?
  end

  def hardhat?
    name.downcase.include?('hardhat')
  end

  def unreturned_checker
    return unless hardhat? && checked_out?
    return unless Time.current > Time.zone.local(2026, 4, 14)

    update(status: 'unreturned')
  end

  def hardhat_status_label
    return nil unless hardhat?

    status || 'good condition'
  end

  def self.checked_out_by_organization(organization)
    joins(:checkouts).where(
      checkouts: {
        organization_id: organization,
        checked_in_at: nil
      }
    )
  end

  def self.checked_out_count_by_type_and_org(tool_type, organization)
    joins(:checkouts).where(
      tool_type: tool_type,
      checkouts: { organization_id: organization, checked_in_at: nil }.count
    )
  end

  delegate :name, to: :tool_type, allow_nil: true

  def formatted_name
    return "#{barcode}: #{name} - #{description}" if description.present?

    "#{barcode}: " + name
  end

  def link
    tool_path(self)
  end
end
