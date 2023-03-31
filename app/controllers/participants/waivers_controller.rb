# frozen_string_literal: true
class Participants::WaiversController < ApplicationController
  include PersonalPathable
  before_action :require_authentication
  before_action -> { fix_personal_path(waiver_path, params[:id].to_i) },
                :load_participant,
                only: :show
  load_and_authorize_resource :participant, parent: false
  before_action :require_safety_briefing

  def show
  end

  def update
    @participant.assign_attributes(participant_params)
    if @participant.save(context: :waiver_signing)
      redirect_to @participant, notice: t('.notice', name: @participant.name)
    else
      # TODO: Don't leak participant_id in uri on personal paths
      @participant.restore_attributes
      flash.now[:alert] = t('.alert')
      render :show, status: :unprocessable_entity
    end
  end

  private

  def load_participant
    @participant = Current.user if params[:id].blank?
  end

  def require_safety_briefing
    return if @participant.watched_safety_video?
    redirect_to participant_safety_briefing_path(@participant)
  end

  def participant_params
    params.require(:participant).permit(
      Current.ability.permitted_attributes(:update, @participant)
    )
  end
end
