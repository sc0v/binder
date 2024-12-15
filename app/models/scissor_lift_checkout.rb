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

  scope :current, -> { where(checked_in_at: nil) }
end
