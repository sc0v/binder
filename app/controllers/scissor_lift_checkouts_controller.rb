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

    if scissor_lift_ids.blank? || scissor_lift_ids.empty?
      flash.alert = "Add at least one scissor lift to checkout."
      redirect_to scissor_lifts_path
      return
    end

    if participant.blank?
      flash.alert = "Select a valid participant to checkout."
      redirect_to scissor_lifts_path
      return
    end

    result = ScissorLiftCheckout.checkout_batch(
      organization: @organization,
      participant: participant,
      scissor_lift_ids: scissor_lift_ids
    )

    session[:scissor_lifts] = result[:remaining_ids]

    if session[:scissor_lifts].empty?
      session[:borrower_id] = nil
      checked_out_names = result[:checked_out].map { |checkout| checkout.scissor_lift&.name }.compact
      flash.notice = "#{checked_out_names.join(", ")} checked out to #{participant.name}"
    else
      lifts_errors = result[:failed].map do |checkout|
        name = checkout.scissor_lift&.name || "Scissor lift"
        "#{name} (#{checkout.errors.full_messages.join(", ")})"
      end
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
    checkout = @scissor_lift.current_checkout
    if checkout.blank?
      redirect_to scissor_lifts_path, alert: "#{params[:name]} is not checked out." 
      return
    end
    result = checkout.renew_for(duration_hours: params[:duration])

    if result.errors.any?
      redirect_to scissor_lifts_path, alert: "Problem renewing #{params[:name]}: #{result.errors.full_messages.join(", ")}"
      return
    end

    redirect_to scissor_lifts_path, notice: "#{params[:name]} successfully renewed for #{params[:duration]} hours."
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
      checkout = @scissor_lift.current_checkout
      if checkout.blank?
        redirect_to scissor_lifts_path, alert: "#{params[:name]} is already checked in." and return
      end
      result = checkout.checkin(forfeit: params[:checkin_type] == "1")
      if result.errors.any?
        redirect_to scissor_lifts_path, alert: "Problem checking in #{params[:name]}: #{result.errors.full_messages.join(", ")}"
        return
      end
      if result.is_forfeit
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
