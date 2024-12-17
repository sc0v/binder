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
