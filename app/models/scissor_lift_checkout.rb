class ScissorLiftCheckout < ApplicationRecord
  validates_associated :scissor_lift
  validate :checkout_info

  def checkout_info
    if checked_in_at.nil? && due_at.nil?
      errors.add(:checked_in_at, 'should not be nil when due_at is nil')
    elsif !checked_in_at.nil? && !due_at.nil?
      errors.add(:checked_in_at, 'should be nil when due_at is not nil')
    end
  end

  belongs_to :scissor_lift
  belongs_to :participant
  belongs_to :organization

  delegate :name, :link, to: :scissor_lift, prefix: true
  delegate :name, :link, to: :participant, prefix: true
  delegate :name, :link, to: :organization, prefix: true

  scope :current, -> { where(checked_in_at: nil) }

  def self.checkout_batch(organization:, participant:, scissor_lift_ids:)
    return { status: :error, message: "Select a valid organization." } if organization.blank?

    timeout_end = timeout_end(organization)
    if timeout_end.present?
      return {
        status: :error,
        message: "#{organization.name} is on timeout for using a scissor lift without a green wristband until #{timeout_end.strftime('%l:%M %p')}!"
      }
    end

    if scissor_lift_ids.blank? || scissor_lift_ids.empty?
      return { status: :error, message: "Add at least one scissor lift to checkout." }
    end

    return { status: :error, message: "Select a valid participant to checkout." } if participant.blank?

    unless participant.scissor_lift_certified?
      return { status: :error, message: "#{participant.name} is not scissor lift certified." }
    end

    checked_out = []
    errors = []
    remaining_ids = scissor_lift_ids.dup

    scissor_lift_ids.each do |scissor_lift_id|
      begin
        lift = ScissorLift.find(scissor_lift_id)
        if lift.is_checked_out?
          errors << { name: lift.name, error: 'Scissor lift is already checked out' }
          next
        end

        checkout = new(
          organization: organization,
          participant: participant,
          scissor_lift: lift,
          checked_out_at: Time.zone.now,
          due_at: Time.zone.now + 2.hours
        )

        if checkout.save
          checked_out << lift.name
          remaining_ids -= [scissor_lift_id]
        else
          errors << { name: lift.name, error: checkout.errors.full_messages.join(", ") }
        end
      rescue StandardError
        return {
          status: :error,
          message: "Error checking out '#{lift&.name || scissor_lift_id}'"
        }
      end
    end

    { status: :ok, checked_out: checked_out, errors: errors, remaining_ids: remaining_ids }
  end

  def self.renew_for(scissor_lift:, duration_hours:)
    checkout = scissor_lift.current_checkout
    return { status: :not_checked_out } if checkout.blank?

    checkout.due_at = Time.zone.now + duration_hours.to_i.hours
    if checkout.save
      { status: :ok }
    else
      { status: :error }
    end
  end

  def self.checkin_for(scissor_lift:, forfeit:)
    checkout = scissor_lift.current_checkout
    return { status: :already_checked_in } if checkout.blank?

    checkout.checked_in_at = Time.zone.now
    checkout.due_at = nil
    checkout.is_forfeit = forfeit
    checkout.save!

    { status: :ok, forfeit: checkout.is_forfeit }
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
