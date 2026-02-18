# frozen_string_literal: true

class PwaController < ApplicationController
  skip_before_action :verify_authenticity_token
  skip_before_action :set_current_ability, raise: false
  skip_before_action :authenticate_user!, raise: false

  def manifest
    render file: Rails.root.join('app/views/pwa/manifest.json.erb'), content_type: "application/manifest+json"
  end

  def service_worker
    render file: Rails.root.join('app/views/pwa/service-worker.js'), content_type: "text/javascript"
  end
end