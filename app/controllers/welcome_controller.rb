# frozen_string_literal: true
class WelcomeController < ApplicationController
  def index
    @notes = Note.accessible_by(Current.ability).unhidden
    @note = Note.new
  end
end
