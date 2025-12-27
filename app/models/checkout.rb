# frozen_string_literal: true

class Checkout < ApplicationRecord
  include Messenger

  # For lookups

  attr_accessor :card_number

  validates :checked_out_at, presence: true
  validates :tool, :organization, :participant, presence: true
  validates_associated :tool, :organization, :participant
  validate :only_one_active_checkout_per_tool
  validate :not_already_checked_in, on: :update

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

  def not_already_checked_in
    return if checked_in_at_was.blank?

    errors.add(:base, 'Checkout is already checked in')
  end

  def self.checkout_batch(organization:, participant:, tool_ids:)
    checked_out = []
    failed = []
    remaining_ids = tool_ids.dup

    if tool_ids.blank?
      checkout = new(
        organization: organization,
        participant: participant,
        checked_out_at: Time.zone.now
      )
      checkout.errors.add(:base, 'Add at least one tool to checkout.')
      failed << checkout
      return { checked_out: checked_out, failed: failed, remaining_ids: remaining_ids }
    end

    tool_ids.each do |tool_id|
      tool = Tool.find_by(id: tool_id)
      begin
        checkout = new(
          organization: organization,
          participant: participant,
          tool: tool,
          checked_out_at: Time.zone.now
        )

        if checkout.save
          checked_out << checkout
          remaining_ids -= [tool_id]
        else
          failed << checkout
        end
      rescue StandardError
        checkout ||= new(
          organization: organization,
          participant: participant,
          tool: tool,
          checked_out_at: Time.zone.now
        )
        checkout.errors.add(:base, "Error checking out '#{tool&.name || tool_id}'")
        failed << checkout
      end
    end

    { checked_out: checked_out, failed: failed, remaining_ids: remaining_ids }
  end

  def checkin
    self.checked_in_at = Time.zone.now
    save
    self
  end
end
