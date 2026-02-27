# frozen_string_literal: true

class Membership < ApplicationRecord
  validates :participant_id, uniqueness: { scope: :organization_id }

  belongs_to :organization
  belongs_to :participant

  delegate :name, :eppn, to: :participant, prefix: true

  scope :booth_chairs,
        -> { where(is_booth_chair: true).order(:booth_chair_order) }
  scope :validated, -> { where(is_added_by_csv: [false, nil]) }

  def organization_name_formatted
    is_booth_chair? ? "#{organization.name} - Booth Chair" : organization.name
  end
end
