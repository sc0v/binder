# frozen_string_literal: true

# Web Push Notifications Configuration
# Set VAPID_PUBLIC_KEY, VAPID_PRIVATE_KEY in your environment.
# Generate a new key pair with: Webpush.generate_key
vapid_subject_default =
  "mailto:#{Rails.application.config.try(:support_email) || 'support@example.com'}"

Rails.application.config.vapid_public_key = ENV.fetch('VAPID_PUBLIC_KEY')
Rails.application.config.vapid_private_key = ENV.fetch('VAPID_PRIVATE_KEY')
Rails.application.config.vapid_subject = ENV.fetch('VAPID_SUBJECT', vapid_subject_default)
