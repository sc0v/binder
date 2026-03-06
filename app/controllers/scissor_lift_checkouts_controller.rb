# frozen_string_literal: true

class ScissorLiftCheckoutsController < ApplicationController
  before_action :require_update_permission, only: %i[renew checkin]
  before_action :find_scissor_lift_by_name, only: %i[renew checkin]
  before_action :find_current_checkout, only: %i[renew checkin]

  def add
    session[:scissor_lifts] ||= []
    scissor_lift = ScissorLift.find_by(name: params[:name])
    if scissor_lift
      session[:scissor_lifts] |= [scissor_lift.id]
    else
      flash.alert = 'No scissor lift found with that name.'
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
    return if params.dig(:checkout, :organization_id).blank?

    unless can?(:create, ScissorLiftCheckout)
      return redirect_to scissor_lifts_path, alert: t('.unauthorized')
    end

    @organization = Organization.find(params[:checkout][:organization_id])
    run_checkout
  end

  def renew
    result = @checkout.renew_for(duration_hours: params[:duration])
    if result.errors.any?
      return redirect_to scissor_lifts_path, alert: renew_error_alert(result)
    end

    redirect_to scissor_lifts_path,
                notice:
                  "#{params[:name]} successfully renewed for #{params[:duration]} hours."
  end

  def checkin
    result = @checkout.checkin(forfeit: params[:checkin_type] == '1')
    if result.errors.any?
      redirect_to scissor_lifts_path,
                  alert:
                    "Problem checking in #{params[:name]}: #{result.errors.full_messages.join(', ')}"
      return
    end
    redirect_to scissor_lifts_path, notice: checkin_notice(result)
  end

  def index
    checkouts = ScissorLiftCheckout.all

    respond_to do |format|
      format.html
      format.json { render json: { data: checkouts_json(checkouts) } }
    end
  end

  private

  def run_checkout
    participant = Participant.find_by(id: session[:borrower_id])
    scissor_lift_ids = session[:scissor_lifts] || []

    if scissor_lift_ids.blank?
      return redirect_to scissor_lifts_path, alert: t('.no_scissor_lifts')
    end
    if participant.blank?
      return redirect_to scissor_lifts_path, alert: t('.no_participant')
    end

    process_checkout(participant, scissor_lift_ids)
    redirect_to scissor_lifts_path
  end

  def require_update_permission
    return if can?(:update, ScissorLiftCheckout)

    flash.alert = "Not authorized to #{action_name} a Scissorlift."
    redirect_to scissor_lifts_path
  end

  def find_scissor_lift_by_name
    if params[:name].blank?
      redirect_to scissor_lifts_path, alert: t('.no_scissor_lift')
      return
    end
    @scissor_lift = ScissorLift.find_by(name: params[:name])
    unless @scissor_lift
      redirect_to scissor_lifts_path,
                  alert: "Scissor Lift #{params[:name]} does not exist."
    end
  end

  def find_current_checkout
    return unless @scissor_lift

    @checkout = @scissor_lift.current_checkout
    return if @checkout.present?

    alert =
      if action_name == 'checkin'
        "#{params[:name]} is already checked in."
      else
        "#{params[:name]} is not checked out."
      end
    redirect_to scissor_lifts_path, alert:
  end

  def process_checkout(participant, scissor_lift_ids)
    result =
      ScissorLiftCheckout.checkout_batch(
        organization: @organization,
        participant: participant,
        scissor_lift_ids: scissor_lift_ids
      )
    session[:scissor_lifts] = result[:remaining_ids]
    apply_checkout_flash(result, participant)
  end

  def apply_checkout_flash(result, participant)
    if session[:scissor_lifts].empty?
      session[:borrower_id] = nil
      flash.notice =
        "#{checkout_names(result).join(', ')} checked out to #{participant.name}"
    else
      flash.alert = "Problem checking out #{checkout_errors(result).join(', ')}"
    end
  end

  def checkin_notice(result)
    if result.is_forfeit
      "#{params[:name]} successfully forfeited."
    else
      "#{params[:name]} successfully checked in."
    end
  end

  def checkout_names(result)
    result[:checked_out].map { |c| c.scissor_lift&.name }.compact
  end

  def checkout_errors(result)
    result[:failed].map do |c|
      "#{c.scissor_lift&.name || 'Scissor lift'} (#{c.errors.full_messages.join(', ')})"
    end
  end

  def renew_error_alert(result)
    "Problem renewing #{params[:name]}: #{result.errors.full_messages.join(', ')}"
  end

  def checkouts_json(checkouts)
    checkouts.as_json(
      methods: %i[
        scissor_lift_name
        scissor_lift_link
        participant_name
        participant_link
        organization_name
        is_forfeit
      ]
    )
  end
end
