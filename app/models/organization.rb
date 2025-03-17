# frozen_string_literal: true
class Organization < ApplicationRecord
  include Rails.application.routes.url_helpers

  belongs_to :organization_category
  has_many :memberships, dependent: :destroy
  has_many :organization_aliases, dependent: :destroy
  has_many :organization_build_statuses, dependent: :destroy
  has_many :organization_statuses, dependent: :destroy
  has_many :organization_timeline_entries, dependent: :destroy
  has_many :participants, through: :memberships
  has_many :charges, dependent: :destroy
  has_many :tools, through: :checkouts
  has_many :checkouts, dependent: :destroy
  has_many :shifts, dependent: :destroy

  scope :ordered_by_name, -> { order(name: :asc) }

  # TODO: Searching
  scope :search,
        lambda { |term|
          where(
            'lower(name) LIKE lower(?) OR lower(short_name) LIKE lower(?)',
            "%#{term}%",
            "%#{term}%"
          )
        }

  delegate :building?, to: :organization_category
  delegate :name, to: :organization_category, prefix: :category

  def booth_chairs
    memberships.booth_chairs.map(&:participant)
  end

  def validated_participants
    memberships.validated.map(&:participant)
  end

  def validated_non_booth_chairs
    validated_participants.reject { |participant| booth_chairs.include?(participant) }
  end  

  def downtime
    elapsed = 0
    organization_timeline_entries
      .today
      .downtime
      .each { |timeline_entry| elapsed += timeline_entry.duration }

    elapsed.seconds
  end

  def remaining_downtime
    (4.hours - downtime).in_hours
  end

  def link
    organization_path(self)
  end

  def downtime_link
    organization_downtime_index_path(self)
  end

  def short_name
    self[:short_name] || name
  end

  def updated_at(format: :timestamp)
    I18n.l self[:updated_at], format:
  end

  validates :name, presence: true, uniqueness: true
  validates_associated :organization_category
end
