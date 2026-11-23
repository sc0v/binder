# frozen_string_literal: true

# Pin npm packages by running ./bin/importmap

pin 'application', preload: true
pin '@hotwired/turbo-rails', to: 'turbo.min.js', preload: true
pin '@hotwired/stimulus', to: 'stimulus.min.js', preload: true
pin '@hotwired/stimulus-loading', to: 'stimulus-loading.js', preload: true
pin 'pwa', to: 'pwa.js'
pin 'notification_manager', to: 'notification_manager.js'

# youtube-player-api.js //www.youtube.com/player_api
pin_all_from 'app/javascript/custom', under: 'custom'

pin_all_from 'app/javascript/controllers', under: 'controllers'
