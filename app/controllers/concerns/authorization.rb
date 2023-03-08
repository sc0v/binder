# frozen_string_literal: true

module Authorization
  extend ActiveSupport::Concern

  private

  # For use by cancancan
  def current_ability
    @current_ability ||= Ability.new(Current.user)
  end
end
