# frozen_string_literal: true

# Web Push Notifications Configuration
vapid_public_key_default = 'BLxay36PmWKrQkKUNcbSFsZYq2DiTWzVrMKF8JXVfhoA8En6jlRl8osxEd6255YHKZtUu6xJqtzf6p4bjEYGKN0'
vapid_private_key_default = '***REMOVED***'
vapid_subject_default = "mailto:#{Rails.application.config.try(:support_email) || 'support@example.com'}"

Rails.application.config.vapid_public_key = ENV.fetch('VAPID_PUBLIC_KEY', vapid_public_key_default)
Rails.application.config.vapid_private_key = ENV.fetch('VAPID_PRIVATE_KEY', vapid_private_key_default)
Rails.application.config.vapid_subject = ENV.fetch('VAPID_SUBJECT', vapid_subject_default)
