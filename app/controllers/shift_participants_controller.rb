# frozen_string_literal: true

class ShiftParticipantsController < ApplicationController
  # GET
  def new
    Rails.logger.debug('shift_participant')
    @shift = Shift.find(params[:shift_id])
    @shift_participant = ShiftParticipant.new
    @shift_participant.shift = @shift
    @organization = @shift.organization
  end

  def clock_in_by_andrew_id
    participant = find_and_validate_participant
    return unless participant

    clock_in_participant(participant)
  end

  # POST
  def create
    @shift = Shift.find(params[:shift_id])
    return clock_in_by_andrew_id if params[:andrewid].present?

    create_shift_participant
  end

  # UPDATE
  def update
    @shift_participant = ShiftParticipant.find(params[:id])
    @shift_participant.clocked_in_at = Time.zone.now
    @shift_participant.save

    @shift_participant.shift

    redirect_to shift_path(@shift_participant.shift)
    # redirect_back_or_to shift_participant_path(@shift, @shift_participant)
    # respond_with @shift_participant, location: -> { @shift_participant.shift }
  end

  # DELETE /shift_participants/1
  # DELETE /shift_participants/1.json
  def destroy
    @shift_participant = ShiftParticipant.find(params[:id])
    @shift = @shift_participant.shift
    @shift_participant.destroy

    redirect_to shift_path(@shift_participant.shift)
    # redirect_back_or_to shift_participant_path(@shift, @shift_participant)
    # respond_with @shift_participant, location: -> { @shift_participant.shift }
  end

  private

  def clock_in_participant(participant)
    sp = ShiftParticipant.find_or_initialize_by(shift: @shift, participant: participant)
    return already_clocked_in if sp.clocked_in_at.present?

    sp.update!(clocked_in_at: Time.zone.now)
    flash[:notice] = "#{params[:andrewid]} clocked in successfully"
    redirect_to shift_path(@shift)
  end

  def already_clocked_in
    flash[:alert] = "#{params[:andrewid]} is already clocked in"
    redirect_to shift_path(@shift)
  end

  def create_shift_participant
    clock_in_now = params[:shift_participant][:clock_in_now]
    @shift_participant =
      ShiftParticipant.new(
        params.expect(shift_participant: %i[shift_id participant_id])
      )
    @shift_participant.clocked_in_at = clock_in_now == '0' ? nil : Time.zone.now
    @shift_participant.save
    redirect_to shift_path(@shift_participant.shift)
  end

  def find_and_validate_participant
    return if params[:andrewid].blank?

    andrewid = params[:andrewid].strip
    participant = Participant.find_by(eppn: "#{andrewid}@andrew.cmu.edu")
    unless participant
      flash[:alert] = "Participant '#{andrewid}' not found"
      redirect_to new_shift_participant_path(@shift) and return
    end
    participant
  end
end
