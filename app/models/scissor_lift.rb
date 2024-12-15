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
    scissor_lift_checkouts.current.present?
  end

  def current_organization
    scissor_lift_checkouts.current.take.organization.name if scissor_lift_checkouts.current.present?
  end

  def current_participant
    scissor_lift_checkouts.current.take.participant.name if scissor_lift_checkouts.current.present?
  end

  def checked_out_at
    scissor_lift_checkouts.current.take.checked_out_at if scissor_lift_checkouts.current.present?
  end

  def due_at
    scissor_lift_checkouts.current.take.due_at if scissor_lift_checkouts.current.present?
  end
end
