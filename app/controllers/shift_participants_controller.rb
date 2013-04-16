class ShiftParticipantsController < ApplicationController

  def new
    @shift = Shift.find params[:shift_id]
    if session[:participant_id].nil?
      session[:return_url] = new_shift_participant_url( @shift )
    else
      session[:return_url] = nil
      @participant = Participant.find session[:participant_id]
      session[:participant_id] = nil
      @shift_participant = ShiftParticipant.new( :participant => @participant,
                                                 :shift => @shift )
    end
  end

  def create
    shift = Shift.find params[:shift_id]
    shift_participant = ShiftParticipant.new( params[:shift_participant] )
    shift_participant.clocked_in_at = Time.now
    shift_participant.save!

    redirect_to shift_url shift
  end

  def checkout
    shift_participant = ShiftParticipant.where( "shift_id = ? and participant_id = ? and clocked_out_at is null", params[:shift_id], params[:participant_id] ).first
    shift_participant.clocked_out_at = Time.now
    shift_participant.save!
    redirect_to shift_url shift_participant.shift
  end

end
