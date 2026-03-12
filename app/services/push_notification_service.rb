# frozen_string_literal: true

class PushNotificationService
  class << self
    def send(subscription, title:, body:, **options)
      unless subscription.is_a?(NotificationSubscription)
        raise ArgumentError, 'subscription must be a NotificationSubscription'
      end

      deliver(subscription, build_message(title:, body:, **options))
    rescue Webpush::InvalidSubscription, Webpush::ResponseError => e
      Rails.logger.warn("Push notification failed for subscription #{subscription.id}: #{e.message}")
      subscription.update(active: false)
      { error: e.message }
    rescue StandardError => e
      Rails.logger.error("Unexpected error sending push notification: #{e.message}")
      { error: e.message }
    end

    def send_to_all(title:, body:, **options)
      NotificationSubscription.active.map { |s| send(s, title:, body:, **options) }
    end

    def send_to_participant(participant, title:, body:, **options)
      participant.notification_subscriptions.active.map { |s| send(s, title:, body:, **options) }
    end

    private

    def build_message(title:, body:, icon: nil, actions: [], data: {})
      JSON.generate({ title:, body:, icon: icon || '/icon-192x192.png', actions:, data: })
    end

    def deliver(subscription, message)
      Webpush.payload_send(
        endpoint: subscription.endpoint,
        message:,
        p256dh: subscription.p256dh,
        auth: subscription.auth,
        vapid: vapid_config
      )
    end

    def vapid_config
      {
        public_key: Rails.application.config.vapid_public_key,
        private_key: Rails.application.config.vapid_private_key,
        subject: Rails.application.config.vapid_subject
      }
    end
  end
end
