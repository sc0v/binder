# frozen_string_literal: true

class Charge < ApplicationRecord
  validates :charged_at, :amount, presence: true
  validates_associated :issuing_participant, :organization, :charge_type, :receiving_participant, :creating_participant
  validates :amount, numericality: true

  belongs_to :organization
  belongs_to :charge_type
  belongs_to :issuing_participant, class_name: 'Participant'
  belongs_to :receiving_participant, class_name: 'Participant'
  belongs_to :creating_participant, class_name: 'Participant'

  default_scope { order('charged_at DESC') }
  scope :approved, -> { where(is_approved: true) }
  scope :pending, -> { where(is_approved: false) }
  scope :active,       -> { where(active: true) }
  scope :inactive,     -> { where(active: false) }

  delegate :name, to: :charge_type, prefix: :charge_type, allow_nil: true
  delegate :name, :link, to: :organization, prefix: :organization, allow_nil: true
end
