# frozen_string_literal: true

class ShiftParticipant < ApplicationRecord
  validates_associated :shift, :participant

  belongs_to :shift, touch: true
  belongs_to :participant, touch: true

  scope :checked_in_late, -> { joins(:shift).where('starts_at < ? AND clocked_in_at > starts_at', Time.zone.now) }
  scope :active,       -> { where(active: true) }
  scope :inactive,     -> { where(active: false) }

  # For lookups

  attr_accessor :card_number
end
