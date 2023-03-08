# frozen_string_literal: true

module Authentication
  extend ActiveSupport::Concern

  included do
    before_action :set_current_user
  end

  private

  # Set current user if one is authenticated
  def set_current_user
    return if (user_id = cookies.encrypted[:user_id]).blank?

    Current.user = Participant.find(user_id)
  end

  # Redirect to default login when authentication is required
  def require_authentication
    redirect_to login_url if Current.user.blank?
  end
end
