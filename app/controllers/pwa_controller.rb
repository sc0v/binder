# frozen_string_literal: true

class PwaController < ApplicationController
  skip_before_action :verify_authenticity_token
  skip_before_action :set_current_ability, raise: false
  skip_before_action :authenticate_user!, raise: false

  def manifest
    render "pwa/manifest", formats: [:json], content_type: "application/manifest+json"
  end

  def service_worker
    render "pwa/service_worker", formats: [:js], content_type: "text/javascript"
  end
end
