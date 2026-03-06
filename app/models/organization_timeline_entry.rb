# frozen_string_literal: true

class OrganizationTimelineEntry < ApplicationRecord
  include Messenger

  validates :started_at, :entry_type, presence: true
  validates_associated :organization

  enum :entry_type,
       { structural: 0, electrical: 1, downtime: 2, scissor_lift: 3 }

  belongs_to :organization, touch: true

  default_scope { order(:started_at) }
  scope :current, -> { where(ended_at: nil) }
  scope :active, -> { where(active: true) }
  scope :inactive, -> { where(active: false) }
  scope :today, -> { where(started_at: Time.zone.now.all_day) }

  def duration
    return ended_at.to_i - started_at.to_i if ended_at.present?

    DateTime.now.to_i - started_at.to_i
  end

  def already_in_queue?
    return false unless %w[structural electrical].include?(entry_type)
    return false if organization.nil?

    organization
      .organization_timeline_entries
      .current
      .public_send(entry_type)
      .present?
  end

  # notifications
  after_create :notify_start, :notify_booth_committee
  after_update :notify_end

  def notify_start
    return unless entry_type == 'downtime'

    send_sms_to_booth_chairs(
      "Downtime for your organization, #{organization.name}, has started."
    )
  end

  def notify_end
    return unless entry_type == 'downtime'

    remaining =
      Time
        .at(organization.remaining_downtime)
        .utc
        .strftime('%H hours %M minutes')
    send_sms_to_booth_chairs(
      "Downtime for your organization, #{organization.name}, has ended. You have #{remaining} left."
    )
  end

  def notify_booth_committee
    description_text =
      description.blank? ? 'was added' : "was added for: #{description}"
    message_text =
      "#{entry_type.titlecase} Queue: #{organization.short_name} #{description_text}"
    slack_webhook_urls_for_type&.each { |url| send_slack(url, message_text) }
    groupme_bot_ids_for_type&.each { |id| send_groupme(id, message_text) }
  end

  private

  def send_sms_to_booth_chairs(message)
    organization.booth_chairs.each do |chair|
      next unless chair.phone_number.present? && chair.phone_number.length == 10

      send_sms(chair.phone_number, message)
    end
  end

  def slack_webhook_urls_for_type
    case entry_type
    when 'structural'
      [ENV.fetch('SLACK_BOT_STRUCTURAL_WEBHOOK_URL', nil)]
    when 'electrical'
      [
        ENV.fetch('SLACK_BOT_ELECTRICAL_WEBHOOK_URL', nil),
        ENV.fetch('SLACK_BOT_ELECTRICAL_PRIVATE_WEBHOOK_URL', nil)
      ]
    end
  end

  def groupme_bot_ids_for_type
    case entry_type
    when 'structural'
      [ENV.fetch('GROUPME_STRUCTURAL_BOT_ID', nil)]
    when 'electrical'
      [ENV.fetch('GROUPME_ELECTRICAL_BOT_ID', nil)]
    end
  end
end
