class ShiftParticipantsController < ApplicationController
  # DELETE /shift_participants/1
  # DELETE /shift_participants/1.json
  def destroy
    @shift_participant = ShiftParticipant.find(params[:id])
    @shift = @shift_participant.shift
    @shift_participant.destroy
    respond_with @shift_participant, location: -> { @shift_participant.shift }
  end

  # GET
  def new
    @shift_participant = ShiftParticipant.new
    shift = Shift.find(params[:shift_id])
    @shift_participant.shift = shift
  end

  # POST
  def create
    @shift_participant = ShiftParticipant.new(params.require(:shift_participant).permit(:shift_id, :participant_id))
    @shift_participant.clocked_in_at = Time.now
    @shift_participant.save
    respond_with @shift_participant, location: -> { @shift_participant.shift }
  end
end

