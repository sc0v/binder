# frozen_string_literal: true

class Applets::WristbandLookupController < ApplicationController
  def index
    return if params[:participant_search].blank?

    @participant = Participant.find_by_search(params[:participant_search])
    flash.now[:alert] = t('.no_participant') if @participant.blank?
  end
end
