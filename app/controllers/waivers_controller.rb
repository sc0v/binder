class WaiversController < ApplicationController

  def new
    if current_user.participant.has_signed_waiver
      flash[:notice] = "You have already agreed to the release."
    end
    
  end


  def create
    if params[:adult].blank?
      flash[:error] = "You must be 18 or older to sign the electronic waiver. Please contact Tim Leonard (leonardt@andrew.cmu.edu)."
      redirect_to action: :new
    elsif params[:agree].blank?
      flash[:error] = "You must agree to the terms of the release."
      redirect_to action: :new
    elsif params[:phone_number] == ""
      flash[:error] = "You must provide a mobile phone number"
      redirect_to action: :new
    else
      current_user.participant.phone_number = params[:phone_number]
      c = PhoneCarrier.find(params[:participant][:phone_carrier_id])
      current_user.participant.phone_carrier = c
      current_user.participant.has_signed_waiver = true
      current_user.participant.save!
      flash[:notice] = "Thank you."
      redirect_to root_url
    end

  end
end
