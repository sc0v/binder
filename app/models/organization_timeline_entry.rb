# frozen_string_literal: true

include Messenger

class OrganizationTimelineEntry < ApplicationRecord
  validates :started_at, :entry_type, presence: true
  validates_associated :organization

  enum entry_type: { structural: 0, electrical: 1, downtime: 2 }

  belongs_to :organization, touch: true

  default_scope { order('started_at asc') }
  scope :current, -> { where(ended_at: nil) }
  scope :active,       -> { where(active: true) }
  scope :inactive,     -> { where(active: false) }
  scope :today, -> { where("started_at >= ? AND started_at < ?", Date.today, 1.day.from_now)} 

  def duration
    return ended_at.to_i - started_at.to_i if ended_at.present?

    DateTime.now.to_i - started_at.to_i
  end

  def already_in_queue?
    %w[structural electrical].include?(entry_type) &&
      !organization.organization_timeline_entries.current.send(entry_type).empty?
  end

  # notifcations
  after_create :notifyStart, :notify_booth_committee
  after_update :notifyEnd

  def notifyStart
    return unless entry_type == 'downtime'

    organization.booth_chairs.each do |chair|
      if chair.phone_number.length == 10
        send_sms(chair.phone_number, "Downtime for your organization, #{organization.name}, has started.")
      end
    end
  end

  def notifyEnd
    return unless entry_type == 'downtime'

    organization.booth_chairs.each do |chair|
      if chair.phone_number.length == 10
        send_sms(chair.phone_number,
                 "Downtime for your organization, #{organization.name}, has ended. You have #{Time.at(organization.remaining_downtime).utc.strftime('%H hours %M minutes')} left.")
      end
    end
  end

  def notify_booth_committee
    # post in the relevant groupme/slack when someone joins a queue

    slack_webhook_urls = case entry_type
                         when 'structural'
                           [ENV.fetch('SLACK_BOT_STRUCTURAL_WEBHOOK_URL', nil)]
                         when 'electrical'
                           [ENV.fetch('SLACK_BOT_ELECTRICAL_WEBHOOK_URL', nil),
                            ENV.fetch('SLACK_BOT_ELECTRICAL_PRIVATE_WEBHOOK_URL', nil)]
                         end

    groupme_bot_ids = case entry_type
                      when 'structural'
                        [ENV.fetch('GROUPME_STRUCTURAL_BOT_ID', nil)]
                      when 'electrical'
                        [ENV.fetch('GROUPME_ELECTRICAL_BOT_ID', nil)]
                      end

    description_text = description.blank? ? 'was added' : "was added for: #{description}"
    message_text = "#{entry_type.titlecase} Queue: #{organization.short_name} #{description_text}"

    slack_webhook_urls&.each do |slack_webhook_url|
      send_slack(slack_webhook_url, message_text)
    end

    return if groupme_bot_ids.nil?

    groupme_bot_ids.each do |groupme_bot_id|
      send_groupme(groupme_bot_id, message_text)
    end
  end
end
