class WaiversController < ApplicationController
  before_filter :require_authenticated_user

  def new
    if params[:participant_id].nil? or !current_user.participant.is_scc?
      @user = current_user.participant
    else
      @user = Participant.find params[:participant_id]
    end

    if @user.has_signed_waiver
      flash[:notice] = "You have already agreed to the release."
    elsif !flash[:error]
      @user.start_waiver_timer
    end

    @should_see_video = !flash[:error] && cannot?(:skip_video, WaiversController)

  end


  def create
    if params[:participant_id].nil? or !current_user.participant.is_scc?
      @participant = current_user.participant
    else
      @participant = Participant.find params[:participant_id]
    end



    if @participant.is_waiver_cheater? && cannot?(:skip_video, WaiversController)
      @participant.start_waiver_timer
      redirect_to '/cheating.html'
    elsif params[:adult].blank?
      flash[:error] = "You must be 18 or older to sign the electronic waiver. Please contact Andrew Greenwald (<a target='_blank' href='mailto:asgreen@andrew.cmu.edu'>asgreen@andrew.cmu.edu</a>)."
      redirect_to action: :new
    elsif params[:agree].blank?
      flash[:error] = "You must agree to the terms of the release."
      redirect_to action: :new
    elsif params[:phone_number] == ""
      flash[:error] = "You must provide a mobile phone number."
      redirect_to action: :new
    elsif params[:signature] != @participant.name
      flash[:error] = "You must electronically sign the waiver with your full name as it appears on the waiver."
      redirect_to action: :new
    else
      @participant.phone_number = params[:phone_number]
      c = PhoneCarrier.find(params[:participant][:phone_carrier_id])
      @participant.phone_carrier = c
      @participant.has_signed_waiver = true
      @participant.save!

      flash[:notice] = "Thank you for completing the waiver."
      redirect_to root_path
      
    end

  end


end
