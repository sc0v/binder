# frozen_string_literal: true
module ApplicationHelper
  include Pagy::Frontend
  # Flash
  #
  # Map flash categories to css classes.
  def flash_css_class(name)
    "flash-#{name} " +
      case name
      when 'notice'
        'green invert'
      when 'alert'
        'red invert'
      else
        'gold'
      end
  end
end
