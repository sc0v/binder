# frozen_string_literal: true

class ShiftParticipantsController < ApplicationController
  # GET
  def new
    @shift_participant = ShiftParticipant.new
    shift = Shift.find(params[:shift_id])
    @shift_participant.shift = shift
  end

  # POST
  def create
    clock_in_now = params[:shift_participant][:clock_in_now]
    @shift_participant = ShiftParticipant.new(params.require(:shift_participant).permit(:shift_id, :participant_id))

    @shift_participant.clocked_in_at = if clock_in_now == '0'
                                         nil
                                       else
                                         Time.zone.now
                                       end
    @shift_participant.save
    respond_with @shift_participant, location: -> { @shift_participant.shift }
  end

  # UPDATE
  def update
    @shift_participant = ShiftParticipant.find(params[:id])
    @shift_participant.clocked_in_at = Time.zone.now
    @shift_participant.save
    respond_with @shift_participant, location: -> { @shift_participant.shift }
  end

  # DELETE /shift_participants/1
  # DELETE /shift_participants/1.json
  def destroy
    @shift_participant = ShiftParticipant.find(params[:id])
    @shift = @shift_participant.shift
    @shift_participant.destroy
    respond_with @shift_participant, location: -> { @shift_participant.shift }
  end
end
