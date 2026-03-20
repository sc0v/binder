# frozen_string_literal: true

class PushNotificationService
  class << self
    def send(subscription, title:, body:, **)
      unless subscription.is_a?(NotificationSubscription)
        raise ArgumentError, 'subscription must be a NotificationSubscription'
      end

      deliver(subscription, build_message(title:, body:, **))
    rescue Webpush::ExpiredSubscription,
           Webpush::InvalidSubscription,
           Webpush::ResponseError => e
      handle_delivery_failure(subscription, e)
    rescue StandardError => e
      handle_unexpected_error(e)
    end

    def send_to_all(title:, body:, **)
      NotificationSubscription.active.map { |s| send(s, title:, body:, **) }
    end

    def send_to_participant(participant, title:, body:, **)
      participant.notification_subscriptions.active.map do |s|
        send(s, title:, body:, **)
      end
    end

    private

    def build_message(title:, body:, icon: nil, actions: [], data: {})
      JSON.generate(
        { title:, body:, icon: icon || '/icon-192x192.png', actions:, data: }
      )
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

    def handle_delivery_failure(subscription, error)
      Rails.logger.warn("Push failed (#{subscription.id}): #{error.message}")
      subscription.update(active: false)
      { error: error.message }
    end

    def handle_unexpected_error(error)
      Rails.logger.error("Unexpected push error: #{error.message}")
      { error: error.message }
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
