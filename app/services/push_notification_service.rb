# frozen_string_literal: true

class PushNotificationService
  def self.send(subscription, title:, body:, icon: nil, actions: [], data: {})
    unless subscription.is_a?(NotificationSubscription)
      raise ArgumentError,
            'subscription must be a NotificationSubscription'
    end

    payload = {
      title:,
      body:,
      icon: icon || '/icon-192x192.png',
      actions:,
      data:
    }

    message = JSON.generate(payload)
    vapid_public_key = Rails.application.config.vapid_public_key
    vapid_private_key = Rails.application.config.vapid_private_key

    Webpush.payload_send(
      endpoint: subscription.endpoint,
      message:,
      p256dh: subscription.p256dh,
      auth: subscription.auth,
      vapid: {
        public_key: vapid_public_key,
        private_key: vapid_private_key,
        subject: Rails.application.config.vapid_subject
      }
    )
  rescue Webpush::InvalidSubscription, Webpush::ResponseError => e
    Rails.logger.warn("Push notification failed for subscription #{subscription.id}: #{e.message}")
    subscription.update(active: false)
    { error: e.message }
  rescue StandardError => e
    Rails.logger.error("Unexpected error sending push notification: #{e.message}")
    { error: e.message }
  end

  def self.send_to_all(title:, body:, icon: nil, actions: [], data: {})
    subscriptions = NotificationSubscription.active
    subscriptions.map do |subscription|
      send(subscription, title:, body:, icon:, actions:, data:)
    end
  end

  def self.send_to_participant(participant, title:, body:, icon: nil, actions: [], data: {})
    subscriptions = participant.notification_subscriptions.active
    subscriptions.map do |subscription|
      send(subscription, title:, body:, icon:, actions:, data:)
    end
  end
end
