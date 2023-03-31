# frozen_string_literal: true
class Participants::SafetyBriefingsController < ApplicationController
  include PersonalPathable
  before_action :require_authentication
  before_action -> {
                  fix_personal_path(safety_briefing_path, params[:id].to_i)
                },
                :load_participant,
                only: :show
  load_and_authorize_resource :participant, parent: false

  def show
    @safety_video_id = Rails.configuration.youtube[:safety_video][:id]
    @safety_video_duration =
      Rails.configuration.youtube[:safety_video][:duration].to_i

    session[:safety_briefing_expected_end_at] = Time.zone.now
    return if can?(:skip_safety_video, Current.user)

    # Participants must stay on the page for the duration of the video to receive credit
    session[:safety_briefing_expected_end_at] += @safety_video_duration
  end

  def update
    @participant.assign_attributes(participant_params)
    if @participant.save(context: :safety_briefing)
      session.delete(:safety_briefing_expected_end_at)
      redirect_to participant_waiver_path(@participant)
    else
      flash.alert =
        t('.alert', errors: @participant.errors.full_messages.join(', '))
      redirect_to action: :show
    end
  end

  private

  def load_participant
    @participant = Current.user if params[:id].blank?
  end

  def participant_params
    params
      .require(:participant)
      .permit(:watched_safety_video)
      .merge(
        safety_briefing_expected_end_at:
          session[:safety_briefing_expected_end_at]
      )
  end
end
