# frozen_string_literal: true

module WelcomeHelper
  def greeting
    content_tag(:h1, "Welcome, #{Current.user.name}!") if Current.user
  end
end
