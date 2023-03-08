# frozen_string_literal: true

class SessionsController < ApplicationController
  def create
    u = Participant.from_omniauth(request.env['omniauth.auth'])
    if u.present?
      cookies.encrypted[:user_id] = u.id
    else
      # TODO: I18l
      flash[:error] = '<strong>No user found.</strong>'
    end
    redirect_to request.env['omniauth.origin'] || root_url
  end

  def destroy
    cookies.encrypted[:user_id] = nil

    # TODO: I18l
    flash[:success] = '<strong>Logout completed successfully.</strong>'

    # Redirect to SSO logout if configured, otherwise root
    strategy = request.env['omniauth.strategy']
    slo_url = strategy.options['idp_slo_service_url'] if strategy.present?
    redirect_to slo_url || root_url
  end
end
