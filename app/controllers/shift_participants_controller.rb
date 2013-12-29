class ShiftParticipantsController < ApplicationController
  # DELETE /shift_participants/1
  # DELETE /shift_participants/1.json
  def destroy
    @shift_participant = ShiftParticipant.find(params[:id])
    @shift_participant.destroy

    respond_to do |format|
      format.html { redirect_to shift_participants_url }
      format.json { head :no_content }
    end
  end

  # GET
  def new
    @shift_participant = ShiftParticipant.new
    shift = Shift.find(params[:shift_id])
    @shift_participant.shift = shift

    respond_to do |format|
      format.html # new_shift_clock_in.html.erb
      format.json { render json: @shift_participants }
    end
  end

  # POST
  def create
    @shift_participant = ShiftParticipant.new(params.require(:shift_participant).permit(:shift_id, :participant_id))
    @shift_participant.clocked_in_at = Time.now

    respond_to do |format|
      if @shift_participant.save
        format.html { redirect_to @shift_participant.shift, notice: "#{@shift_participant.participant.name} was successfully checked in." }
        format.json { render json: @shift_participant.shift, status: :created, location: @shift_participant.shift }
      else
        format.html { render action: "new" }
        format.json { render json: @shift_participant.errors, status: :unprocessable_entity }
      end
    end
  end
end

