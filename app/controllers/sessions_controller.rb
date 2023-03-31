# frozen_string_literal: true
class SessionsController < ApplicationController
  def create
    redirect_url = login_redirect_path(request.env['omniauth.origin'])
    cookies.encrypted[:user_id] = load_user(request.env['omniauth.auth'])
    redirect_to redirect_url
  rescue StandardError
    redirect_to redirect_url, alert: t('.alert', message: help_message)
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
