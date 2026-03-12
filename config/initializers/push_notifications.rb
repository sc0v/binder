# frozen_string_literal: true

# Web Push Notifications Configuration
Rails.application.config.vapid_public_key = ENV.fetch('VAPID_PUBLIC_KEY',
                                                      'BLxay36PmWKrQkKUNcbSFsZYq2DiTWzVrMKF8JXVfhoA8En6jlRl8osxEd6255YHKZtUu6xJqtzf6p4bjEYGKN0')
Rails.application.config.vapid_private_key = ENV.fetch('VAPID_PRIVATE_KEY',
                                                       '***REMOVED***')
Rails.application.config.vapid_subject = ENV.fetch('VAPID_SUBJECT',
                                                   "mailto:#{Rails.application.config.try(:support_email) || 'support@example.com'}")
