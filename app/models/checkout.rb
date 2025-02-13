# frozen_string_literal: true

class Checkout < ApplicationRecord
  include Messenger

  # For lookups

  attr_accessor :card_number

  validates :checked_out_at, presence: true
  validates_associated :tool, :organization, :participant
  validate :only_one_active_checkout_per_tool

  belongs_to :participant, touch: true
  belongs_to :organization, touch: true
  belongs_to :tool, touch: true

  default_scope { order('tool_id ASC, checked_out_at DESC') }
  scope :old, -> { where.not(checked_in_at: nil) }
  scope :current, -> { where(checked_in_at: nil) }
  scope :active,       -> { where(active: true) }
  scope :inactive,     -> { where(active: false) }

  def only_one_active_checkout_per_tool
    if Checkout.where(tool_id: tool_id, checked_in_at: nil).where.not(id: id).exists?
      errors.add(:tool_id, "already has an active checkout")
    end
  end
end
