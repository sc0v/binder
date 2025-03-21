# frozen_string_literal: true
class SessionsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: :create
  before_action :setup_mock_auth, if: -> { Rails.env.development? && params[:participant_key] }

  def create
    unless Rails.env.production?
      auth_hash = OmniAuth.config.mock_auth[:shibboleth]
      participant = Participant.from_omniauth(auth_hash)
      #session[:user_id] = participant.id (not necessary???)
      cookies.encrypted[:user_id] = load_user(request.env['omniauth.auth'])
      flash[:notice] = "Logged in as #{participant.name}"
      redirect_to root_url
    else
      redirect_url = login_redirect_path(request.env['omniauth.origin'])
      begin
        cookies.encrypted[:user_id] = load_user(request.env['omniauth.auth'])
        redirect_to redirect_url
      rescue StandardError
        redirect_to redirect_url, alert: t('.alert', message: help_message)
      end
    end
  end

  def impersonate
    participant = Participant.find_by(id: params[:participant_id])
    if participant
      cookies.encrypted[:user_id] = participant.id
      redirect_to root_path, notice: "Now impersonating #{participant.name}"
    else
      redirect_to root_path, alert: "Participant not found."
    end
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path, alert: "Participant not found."
  end

  def destroy
    cookies.encrypted[:user_id] = nil
    flash.notice = t('.notice')

    # Redirect to SSO logout if configured, otherwise root
    strategy = request.env['omniauth.strategy']
    slo_url = strategy.options['idp_slo_service_url'] if strategy.present?
    redirect_to slo_url || root_url
  end

  private

  def load_user(auth_info)
    Participant.from_omniauth(auth_info).id
  end

  def help_message
    helpers.link_to(t('.help_link'), contact_email_url, class: 'cta')
  end
end
