# frozen_string_literal: true

module Authorization
  extend ActiveSupport::Concern

  included do
    before_action :set_current_ability
  end

  private

  # Set current user's abilities (current user may be nil)
  def set_current_ability
    Current.ability ||= Ability.new(Current.user)
  end

  # CanCanCan requires a current_ability method
  alias current_ability set_current_ability
end
