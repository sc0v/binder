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

    @organization = Organization.find(params[:checkout][:organization_id])
    return if @organization.blank?

    if session[:scissor_lifts].empty?
      flash.alert = "Add at least one scissor lift to checkout."
      redirect_to scissor_lifts_path
      return
    end

    p = Participant.find_by(id: session[:borrower_id])
    if p.blank?
      flash.alert = "Select a valid participant to checkout."
      redirect_to scissor_lifts_path
      return
    elsif !p.wristbands.present? || !p.wristbands.include?(:green)
      flash.alert = "#{p.name} is not scissor lift certified."
      redirect_to scissor_lifts_path
      return
    end

    bad_lifts = []
    good_lifts = []
    lift_errors = []
    session[:scissor_lifts].each do |scissor_lift_id|
      begin
        s = ScissorLift.find(scissor_lift_id)
        if s.is_checked_out?
          bad_lifts.append(s.name)
          lift_errors.append('Scissor lift is already checked out')
          next
        end
        checkout = ScissorLiftCheckout.new(organization: @organization,
                            participant: p,
                            scissor_lift: s,
                            checked_out_at: Time.zone.now,
                            due_at: Time.zone.now + 2.hours)
        if checkout.save
          good_lifts.append(s.name)
          session[:scissor_lifts] -= [scissor_lift_id]
        else
          bad_lifts.append(s.name)
          lift_errors.append(checkout.errors.full_messages.join(", "))
        end
      rescue
        flash.alert = "Error checking out '#{s.name}'"
        redirect_to scissor_lifts_path and return
      end
    end
    
    if session[:scissor_lifts].empty?
      session[:borrower_id] = nil
      flash.notice = "#{good_lifts.join(", ")} checked out to #{p.name}"
    else
      lifts_errors = bad_lifts.zip(lift_errors).map do |e|
        "#{e[0]} (#{e[1]})"
      end
      flash.alert = "Problem checking out #{lifts_errors.join(", ")}"
    end
    redirect_to scissor_lifts_path
  end

  def renew
    if params[:name].blank?
      redirect_to scissor_lifts_path, alert: "No Scissor Lift selected."
      return
    end
    @scissor_lift = ScissorLift.find_by(name: params[:name])
    if @scissor_lift.blank?
      redirect_to scissor_lifts_path, alert: "Scissor Lift #{params[:name]} does not exist."
      return
    end
    @checkout = @scissor_lift.scissor_lift_checkouts.current.first unless @scissor_lift.scissor_lift_checkouts.blank? || @scissor_lift.scissor_lift_checkouts.current.blank?
    if @checkout.blank?
      redirect_to scissor_lifts_path, alert: "#{params[:name]} is not checked out." 
      return
    end
    @checkout.due_at += params[:duration].to_i.hours
    if @checkout.save
      redirect_to scissor_lifts_path, notice: "#{params[:name]} successfully renewed for #{params[:duration]} hours."
    else
      redirect_to scissor_lifts_path, alert: "Problem renewing #{params[:name]}."
    end
  end

  def checkin
    if params[:name].blank?
      redirect_to scissor_lifts_path, alert: "No Scissor Lift selected."
      return
    end
    @scissor_lift = ScissorLift.find_by(name: params[:name])
    if @scissor_lift.blank?
      redirect_to scissor_lifts_path, alert: "Scissor Lift #{params[:name]} does not exist."
    else
      @checkout = @scissor_lift.scissor_lift_checkouts.current.first unless @scissor_lift.scissor_lift_checkouts.blank? || @scissor_lift.scissor_lift_checkouts.current.blank?
      if @checkout.blank?
        redirect_to scissor_lifts_path, alert: "#{params[:name]} is already checked in." and return
      end
      @checkout.checked_in_at = Time.zone.now
      @checkout.due_at = nil
      @checkout.save!
      redirect_to scissor_lifts_path, notice: "#{params[:name]} successfully checked in."
    end
  end
end
