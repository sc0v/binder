# frozen_string_literal: true
# Pin npm packages by running ./bin/importmap

pin 'application', preload: true
pin '@hotwired/turbo-rails', to: 'turbo.min.js', preload: true
pin '@hotwired/stimulus', to: 'stimulus.min.js', preload: true
pin '@hotwired/stimulus-loading', to: 'stimulus-loading.js', preload: true

pin 'tabulator-tables' # @5.2.7
pin 'luxon' # @2.4.0
pin 'list' # @2.0.19
pin 'select2' # @4.1.0
pin 'jquery', preload: true # @3.6.0

pin_all_from 'app/javascript/custom', under: 'custom'
# Custom js file source map:
# cmu.js //www.cmu.edu/common/standard-v6/js/main.6.7.min.js
# youtube-player-api.js //www.youtube.com/player_api

pin_all_from 'app/javascript/controllers', under: 'controllers'
