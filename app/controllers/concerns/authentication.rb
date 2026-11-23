# frozen_string_literal: true

module Authentication
  extend ActiveSupport::Concern

  included { before_action :set_current_user }

  private

  # Set current user if one is authenticated. A cookie for someone who no
  # longer exists signs the browser out.
  def set_current_user
    return if (user_id = cookies.encrypted[:user_id]).blank?

    Current.user = Participant.find_by(id: user_id)
    cookies.delete(:user_id) if Current.user.nil?
  end

  # Redirect to default login when authentication is required
  def require_authentication
    redirect_to login_url if Current.user.blank?
  end
end
