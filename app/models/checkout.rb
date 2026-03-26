# frozen_string_literal: true

class Checkout < ApplicationRecord
  include Messenger

  # For lookups

  attr_accessor :card_number

  validates :checked_out_at, presence: true
  validates_associated :tool, :organization, :participant
  validate :only_one_active_checkout_per_tool
  validate :participant_signed_waiver, on: :create
  validate :participant_belongs_to_org
  validate :not_already_checked_in, on: :update

  belongs_to :participant, touch: true
  belongs_to :organization, touch: true
  belongs_to :tool, touch: true

  default_scope { order(:tool_id, checked_out_at: :desc) }
  scope :old, -> { where.not(checked_in_at: nil) }
  scope :current, -> { where(checked_in_at: nil) }
  scope :active, -> { where(active: true) }
  scope :inactive, -> { where(active: false) }

  def checkin
    self.checked_in_at = Time.zone.now
    save
    self
  end

  def only_one_active_checkout_per_tool
    unless Checkout
             .where(tool_id: tool_id, checked_in_at: nil)
             .where.not(id: id)
             .exists?
      return
    end

    errors.add(:tool_id, 'already has an active checkout')
  end

  def participant_signed_waiver
    return if participant.blank? || participant.signed_waiver?

    errors.add(:participant, 'has not signed the waiver')
  end

  def not_already_checked_in
    return if checked_in_at_was.blank?

    errors.add(:base, 'Checkout is already checked in')
  end

  def participant_belongs_to_org
    return if organization_id.blank? || participant_id.blank?
    if Membership.exists?(
         organization_id: organization_id,
         participant_id: participant_id
       )
      return
    end

    errors.add(:participant, 'does not belong to organization')
  end

  def self.checkout_batch(organization:, participant:, tool_ids:)
    checked_out, failed =
      tool_ids
        .map { |id| attempt_checkout(id, organization, participant) }
        .partition { |c| c.errors.none? }
    { checked_out:, failed:, remaining_ids: failed.map(&:tool_id) }
  end

  def self.checkin_batch(tool_ids:)
    attempts = tool_ids.map(&:to_i).map { |id| attempt_checkin(id) }
    errors = attempts.filter_map { |a| a[:error] }
    remaining_ids = attempts.filter_map { |a| a[:remaining_id] }
    { checked_in: tool_ids.size - errors.size, errors:, remaining_ids: }
  end

  def self.attempt_checkout(tool_id, organization, participant)
    create(tool_id:, organization:, participant:, checked_out_at: Time.zone.now)
  end
  private_class_method :attempt_checkout

  def self.attempt_checkin(tool_id)
    tool = Tool.find_by(id: tool_id)
    unless tool
      return(
        { error: { type: :missing_tool, id: tool_id }, remaining_id: tool_id }
      )
    end

    checkout = tool.checkouts.current.first&.tap(&:checkin)
    return {} if checkout.nil? || checkout.errors.blank?

    {
      error: {
        type: :checkin_error,
        message: checkout.errors.full_messages.join(', ')
      },
      remaining_id: tool_id
    }
  end
  private_class_method :attempt_checkin
end
