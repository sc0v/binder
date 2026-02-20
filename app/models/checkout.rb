# frozen_string_literal: true

class Checkout < ApplicationRecord
  include Messenger

  # For lookups

  attr_accessor :card_number

  validates :checked_out_at, presence: true
  validates :tool, :organization, :participant, presence: true
  validates_associated :tool, :organization, :participant
  validate :participant_signed_waiver, on: :create
  validate :participant_belongs_to_org
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

  def participant_signed_waiver
    return if participant.blank? || participant.signed_waiver?

    errors.add(:participant, 'has not signed the waiver')
  end

  def not_already_checked_in
    return if checked_in_at_was.blank?

    errors.add(:base, 'Checkout is already checked in')
  end

  def participant_belongs_to_org
    Rails.logger.debug(organization_id)
    Rails.logger.debug(participant_id)

    return if organization_id.blank? || participant_id.blank?

    return if Membership.exists?(organization_id: organization_id, participant_id: participant_id)

    errors.add(:participant, 'does not belong to organization')
  end

  def self.checkout_batch(organization:, participant:, tool_ids:)
    checked_out = []
    failed = []
    remaining_ids = tool_ids.dup

    if tool_ids.blank?
      failed << missing_tools_checkout(organization: organization, participant: participant)
      return { checked_out: checked_out, failed: failed, remaining_ids: remaining_ids }
    end

    tool_ids.each do |tool_id|
      tool = Tool.find_by(id: tool_id)
      if tool.blank?
        failed << missing_tool_checkout(organization: organization, participant: participant, tool_id: tool_id)
        next
      end

      checkout = build_checkout(organization: organization, participant: participant, tool: tool)
      begin
        if checkout.save
          checked_out << checkout
          remaining_ids -= [tool_id]
        else
          apply_checkout_error(checkout, tool)
          failed << checkout
        end
      rescue StandardError => e
        failed << error_checkout_for_exception(
          checkout: checkout,
          organization: organization,
          participant: participant,
          tool: tool,
          tool_id: tool_id,
          exception: e
        )
      end
    end

    { checked_out: checked_out, failed: failed, remaining_ids: remaining_ids }
  end

  def checkin
    self.checked_in_at = Time.zone.now
    save
    self
  end

  def self.build_checkout(organization:, participant:, tool: nil)
    new(
      organization: organization,
      participant: participant,
      tool: tool,
      checked_out_at: Time.zone.now
    )
  end

  def self.missing_tools_checkout(organization:, participant:)
    checkout = build_checkout(organization: organization, participant: participant)
    checkout.errors.add(:base, 'Add at least one tool to checkout.')
    checkout
  end

  def self.missing_tool_checkout(organization:, participant:, tool_id:)
    checkout = build_checkout(organization: organization, participant: participant)
    checkout.errors.add(:base, "Tool #{tool_id} not found.")
    checkout
  end

  def self.apply_checkout_error(checkout, tool, exception: nil)
    message = format_checkout_error(tool_name: tool.name, errors: checkout.errors, exception: exception)
    checkout.errors.clear
    checkout.errors.add(:base, message)
  end

  def self.format_checkout_error(tool_name:, errors:, exception: nil)
    if errors[:tool_id].include?("already has an active checkout") && errors.attribute_names == [:tool_id]
      return "#{tool_name} already checked out."
    end

    details = exception ? exception.message : errors.full_messages.join(', ')
    "Could not check out '#{tool_name}': #{details}"
  end

  def self.error_checkout_for_exception(checkout:, organization:, participant:, tool:, tool_id:, exception:)
    checkout ||= build_checkout(organization: organization, participant: participant, tool: tool)
    name = tool&.name || tool_id
    message = format_checkout_error(tool_name: name, errors: checkout.errors, exception: exception)
    checkout.errors.clear
    checkout.errors.add(:base, message)
    checkout
  end

  private_class_method :build_checkout,
                       :missing_tools_checkout,
                       :missing_tool_checkout,
                       :apply_checkout_error,
                       :format_checkout_error,
                       :error_checkout_for_exception
end
