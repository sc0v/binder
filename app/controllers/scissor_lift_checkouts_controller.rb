class ScissorLiftCheckoutsController < ApplicationController
  def add
    session[:scissor_lifts]||=[]
    scissor_lift = ScissorLift.find_by(name: params[:name])
    if scissor_lift.present?
      if !session[:scissor_lifts].include?(scissor_lift.id)
        session[:scissor_lifts].append(scissor_lift.id)
      end
    else
      flash.alert = "No scissor lift found with that name."
    end
    redirect_to params[:url]
  end

  def remove
    session[:scissor_lifts].delete(params[:id].to_i)
    redirect_to scissor_lifts_path
  end

  def reset
    session[:borrower_id] = nil
    session[:scissor_lifts] = nil
    redirect_to scissor_lifts_path
  end

  def checkout
    return unless params[:checkout].present? && params[:checkout][:organization_id].present?

    unless can? :create, ScissorLiftCheckout
      flash.alert = "Not authorized to checkout a Scissorlift."
      redirect_to scissor_lifts_path
      return
    end

    @organization = Organization.find(params[:checkout][:organization_id])
    participant = Participant.find_by(id: session[:borrower_id])
    scissor_lift_ids = session[:scissor_lifts] || []

    result = ScissorLiftCheckout.checkout_batch(
      organization: @organization,
      participant: participant,
      scissor_lift_ids: scissor_lift_ids
    )

    if result[:status] == :error
      flash.alert = result[:message]
      redirect_to scissor_lifts_path
      return
    end

    session[:scissor_lifts] = result[:remaining_ids]

    if session[:scissor_lifts].empty?
      session[:borrower_id] = nil
      flash.notice = "#{result[:checked_out].join(", ")} checked out to #{participant.name}"
    else
      lifts_errors = result[:errors].map { |e| "#{e[:name]} (#{e[:error]})" }
      flash.alert = "Problem checking out #{lifts_errors.join(", ")}"
    end
    redirect_to scissor_lifts_path
  end

  def renew
    unless can? :update, ScissorLiftCheckout
      flash.alert = "Not authorized to renew a Scissorlift."
      redirect_to scissor_lifts_path
      return
    end

    if params[:name].blank?
      redirect_to scissor_lifts_path, alert: "No Scissor Lift selected."
      return
    end
    @scissor_lift = ScissorLift.find_by(name: params[:name])
    if @scissor_lift.blank?
      redirect_to scissor_lifts_path, alert: "Scissor Lift #{params[:name]} does not exist."
      return
    end
    result = ScissorLiftCheckout.renew_for(
      scissor_lift: @scissor_lift,
      duration_hours: params[:duration]
    )

    if result[:status] == :not_checked_out
      redirect_to scissor_lifts_path, alert: "#{params[:name]} is not checked out." 
      return
    end
    if result[:status] == :ok
      redirect_to scissor_lifts_path, notice: "#{params[:name]} successfully renewed for #{params[:duration]} hours."
    else
      redirect_to scissor_lifts_path, alert: "Problem renewing #{params[:name]}."
    end
  end

  def checkin
    unless can? :update, ScissorLiftCheckout
      flash.alert = "Not authorized to checkin a Scissorlift."
      redirect_to scissor_lifts_path
      return
    end

    if params[:name].blank?
      redirect_to scissor_lifts_path, alert: "No Scissor Lift selected."
      return
    end
    @scissor_lift = ScissorLift.find_by(name: params[:name])
    if @scissor_lift.blank?
      redirect_to scissor_lifts_path, alert: "Scissor Lift #{params[:name]} does not exist."
    else
      result = ScissorLiftCheckout.checkin_for(
        scissor_lift: @scissor_lift,
        forfeit: params[:checkin_type] == "1"
      )

      if result[:status] == :already_checked_in
        redirect_to scissor_lifts_path, alert: "#{params[:name]} is already checked in." and return
      end
      if result[:forfeit]
        redirect_to scissor_lifts_path, notice: "#{params[:name]} successfully forfeited."
      else
        redirect_to scissor_lifts_path, notice: "#{params[:name]} successfully checked in."
      end
    end
  end

  def index
    checkouts = ScissorLiftCheckout.all

    respond_to do |format|
      format.html
      format.json do
        data = 
          checkouts.as_json(methods: %i[scissor_lift_name scissor_lift_link participant_name participant_link organization_name is_forfeit])
        render json: {data: }
      end
    end
  end
end
