# frozen_string_literal: true

class Tool < ApplicationRecord
  has_many :checkouts, dependent: :destroy
  has_many :participants, through: :checkouts
  has_many :organizations, through: :checkouts
  belongs_to :tool_type

  validates :barcode, presence: true, uniqueness: true, length: { minimum: 1, maximum: 5 }
  validates_associated :tool_type

  default_scope { order('barcode') }
  scope :by_barcode, -> { order('barcode') }
  scope :by_type, ->(type) { where(tool_type: type) }
  scope :hardhats, -> { joins(:tool_type).where('lower(name) LIKE lower(?)', '%hardhat') }
  scope :radios, -> { joins(:tool_type).where('lower(name) LIKE lower(?)', '%radio') }
  scope :just_tools, lambda {
                       joins(:tool_type).where('lower(name) NOT LIKE lower(?) AND lower(name) NOT LIKE lower(?)', '%radio', '%hardhat')
                     }
  scope :search, lambda { |term|
                   joins(:tool_type).where('lower(name) LIKE lower(?) OR CAST(barcode AS CHAR) LIKE lower(?) OR lower(description) LIKE lower(?)', "%#{term}%", "%#{term}%", "%#{term}%")
                 }
  scope :checked_out, -> { joins(:checkouts).where(checkouts: { checked_in_at: nil }) }
  scope :checked_in, lambda {
                       where('tools.id NOT IN (SELECT checkouts.tool_id FROM checkouts WHERE checked_in_at IS NULL)')
                     }
  scope :active,       -> { where(active: true) }
  scope :inactive,     -> { where(active: false) }

  def current_organization
    checkouts.current.take.organization if checkouts.current.present?
  end

  def current_participant
    checkouts.current.take.participant if checkouts.current.present?
  end

  def is_checked_out?
    !checkouts.current.empty?
  end

  def is_hardhat?
    name.downcase.include?('hardhat')
  end

  def self.checked_out_by_organization(organization)
    joins(:checkouts).where(checkouts: { organization_id: organization, checked_in_at: nil })
  end

  delegate :name, to: :tool_type

  def formatted_name
    return "#{barcode}: #{name} - #{description}" if description.present?

    "#{barcode}: " + name
  end
end
