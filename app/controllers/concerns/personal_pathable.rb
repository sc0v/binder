# frozen_string_literal: true
module PersonalPathable
  extend ActiveSupport::Concern

  private

  # Eliminate participants/:id scope when possible
  def fix_personal_path(personal_path, participant_id, message = nil)
    return if Current.user.blank?
    flash[:alert] = message if message.present?
    redirect_to personal_path if participant_id == Current.user.id
  end
end
