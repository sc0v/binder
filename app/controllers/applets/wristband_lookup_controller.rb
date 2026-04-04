# frozen_string_literal: true

class Applets::WristbandLookupController < ApplicationController
  def index
    return if params[:participant_search].blank?

    @participant = Participant.find_by_search(params[:participant_search])
    flash.now[:alert] = 'No participant found for that ID.' if @participant.blank?
  end
end
