# frozen_string_literal: true

class Applets::PushBroadcastController < ApplicationController
  before_action :require_admin

  def index
  end

  def create
    results =
      PushNotificationService.send_to_all(
        title: params[:title],
        body: params[:body]
      )
    flash_broadcast_results(results)
    redirect_to push_broadcast_path
  end

  private

  def require_admin
    authorize! :manage, NotificationSubscription
  end

  def flash_broadcast_results(results)
    successes = results.count { |r| !r.is_a?(Hash) }
    failures = results.count { |r| r.is_a?(Hash) }
    flash[:notice] = "Sent #{successes} notification(s)."
    flash[:alert] = "#{failures} delivery failure(s)." if failures.positive?
  end
end
