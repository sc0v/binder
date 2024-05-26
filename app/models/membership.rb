# frozen_string_literal: true

class Membership < ApplicationRecord
  validates :participant, presence: true
  validates :organization, presence: true
  validates :participant_id, uniqueness: { scope: :organization_id }

  belongs_to :organization
  belongs_to :participant

  scope :booth_chairs, -> { where(is_booth_chair: true).order('booth_chair_order ASC') }
  scope :active,       -> { where(active: true) }
  scope :inactive,     -> { where(active: false) }

  def organization_name_formatted
    if is_booth_chair?
      "#{organization.name} - Booth Chair"
    else
      organization.name
    end
  end
end
