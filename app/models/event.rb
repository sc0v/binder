# frozen_string_literal: true

include Messenger
class Event < ApplicationRecord
  belongs_to :event_type
  belongs_to :participant

  after_create :send_notifications

  scope :displayable, -> { joins(:event_type).where(is_done: false).where(event_types: { display: true }) }
  scope :active,       -> { where(active: true) }
  scope :inactive,     -> { where(active: false) }

  # send notification to assignee if their phone is in system
  def send_notifications
    return if participant.nil?
    return unless participant.phone_number.length == 10

    # grab first 95 characters of description to serve as a preview
    description_preview = description[0...95]
    send_sms(participant.phone_number,
             "An event in Binder has been assigned to you: #{description_preview}...")
  end
end
