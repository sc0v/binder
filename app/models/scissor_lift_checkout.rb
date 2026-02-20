class ScissorLiftCheckout < ApplicationRecord
  validates_associated :scissor_lift
  validates :organization, :participant, :scissor_lift, presence: true
  validate :checkout_info
  validate :participant_scissor_lift_certified, on: :create
  validate :participant_signed_waiver, on: :create
  validate :scissor_lift_available, on: :create
  validate :organization_not_on_timeout, on: :create
  validate :not_already_checked_in, on: :update

  def checkout_info
    if checked_in_at.nil? && due_at.nil?
      errors.add(:checked_in_at, 'should not be nil when due_at is nil')
    elsif !checked_in_at.nil? && !due_at.nil?
      errors.add(:checked_in_at, 'should be nil when due_at is not nil')
    end
  end

  def participant_scissor_lift_certified
    return if participant.blank? || participant.scissor_lift_certified?

    errors.add(:participant, 'is not scissor lift certified')
  end

  def participant_signed_waiver
    return if participant.blank? || participant.signed_waiver?

    errors.add(:participant, 'has not signed the waiver')
  end

  def scissor_lift_available
    return if scissor_lift.blank? || !scissor_lift.is_checked_out?

    errors.add(:scissor_lift, 'is already checked out')
  end

  def organization_not_on_timeout
    return if organization.blank?

    timeout_until = self.class.timeout_end(organization)
    return if timeout_until.blank?

    errors.add(:organization, "is on timeout for using a scissor lift without a green wristband until #{timeout_until.strftime('%l:%M %p')}")
  end

  def not_already_checked_in
    return if checked_in_at_was.blank?

    errors.add(:base, 'Checkout is already checked in')
  end

  belongs_to :scissor_lift
  belongs_to :participant
  belongs_to :organization

  delegate :name, :link, to: :scissor_lift, prefix: true
  delegate :name, :link, to: :participant, prefix: true
  delegate :name, :link, to: :organization, prefix: true

  scope :current, -> { where(checked_in_at: nil) }

  def renew_for(duration_hours:)
    self.due_at = Time.zone.now + duration_hours.to_i.hours
    save!
    self
  end

  def checkin(forfeit:)
    self.checked_in_at = Time.zone.now
    self.due_at = nil
    self.is_forfeit = forfeit
    save!
    self
  end

  def self.timeout_end(organization)
    org_checkouts = ScissorLiftCheckout.where(organization: organization)
    last_forfeit = org_checkouts.where(is_forfeit: true).order(checked_in_at: :desc).first
    if last_forfeit.present? && last_forfeit.checked_in_at.present? && last_forfeit.checked_in_at + 15.minutes > Time.zone.now
      return last_forfeit.checked_in_at + 15.minutes
    else
      return nil
    end
  end
end
