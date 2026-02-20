class ScissorLift < ApplicationRecord
  include Rails.application.routes.url_helpers

  validates :name, presence: true 

  has_many :scissor_lift_checkouts, dependent: :destroy
  has_one :participant, through: :scissor_lift_checkouts
  has_one :organization, through: :scissor_lift_checkouts

  scope :ordered_by_name, -> { order(name: :asc) }

  def link
    scissor_lift_path(self)
  end

  def is_checked_out?
    current_checkout.present?
  end

  def current_organization
    current_checkout.organization.name if current_checkout.present?
  end

  def current_participant
    current_checkout.participant.name if current_checkout.present?
  end

  def checked_out_at
    current_checkout.checked_out_at if current_checkout.present?
  end

  def due_at
    current_checkout.due_at if current_checkout.present?
  end

  def current_checkout
    scissor_lift_checkouts.current.first
  end
end
