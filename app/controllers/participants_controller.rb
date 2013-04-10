class ParticipantsController < ApplicationController
  def index
    @participant_list = Participant.all
  end
end
