# frozen_string_literal: true

class Tools::CheckoutsController < ApplicationController
  def new
  end

  def add
    session[:tools] ||= []
    tool = Tool.find_by(barcode: params[:barcode])
    update_tool_session(tool)
    redirect_to checkout_tools_path
  end

  def remove
    session[:tools].delete(params[:id].to_i)
    redirect_to checkout_tools_path
  end

  def participant
    store_borrower_in_session
    return redirect_to params[:url] if params[:url].present?

    redirect_to checkout_tools_path
  end

  def reset
    session[:borrower_id] = nil
    session[:tools] = nil
    redirect_to checkout_tools_path
  end

  def create
    unless can? :create, Checkout
      flash.alert = t('.unauthorized')
      redirect_to checkout_tools_path
      return
    end

    return if params.dig(:checkout, :organization_id).blank?

    @organization =
      Organization.find_by(id: params[:checkout][:organization_id])
    participant = Participant.find_by(id: session[:borrower_id])
    tool_ids = Array(session[:tools])

    result =
      Checkout.checkout_batch(
        organization: @organization,
        participant: participant,
        tool_ids: tool_ids
      )
    session[:tools] = result[:remaining_ids]

    if result[:failed].empty? && session[:tools].empty?
      session[:borrower_id] = nil
      flash.notice = "Tools checked out to #{participant&.name}"
    else
      failed_messages = result[:failed].flat_map { |c| c.errors.full_messages }
      flash.alert =
        (failed_messages.presence || ['Problem checking out tools']).join(', ')
    end
    redirect_to checkout_tools_path
  end

  def checkin
    unless can? :update, Checkout
      redirect_to checkout_tools_path, alert: t('.unauthorized')
      return
    end

    @tool = Tool.find_by(barcode: params[:barcode])
    if @tool.blank?
      redirect_to checkout_tools_path,
                  alert: "Tool #{params[:barcode]} does not exist."
      return
    end

    @checkout = @tool.checkouts.current.first
    if @checkout.blank?
      redirect_to checkout_tools_path,
                  alert: "Tool #{params[:barcode]} was never checked out."
      return
    end

    @checkout.checkin
    if @checkout.errors.any?
      redirect_to checkout_tools_path,
                  alert: @checkout.errors.full_messages.join(', ')
      return
    end

    redirect_to checkout_tools_path,
                notice: "Tool #{params[:barcode]} successfully checked in."
  end

  private

  def update_tool_session(tool)
    if tool.nil?
      flash.alert =
        "No tool found with that barcode. #{helpers.link_to 'Create it', new_tool_path, class: 'cta'}"
    elsif tool.checked_out?
      flash.alert = "#{tool.name} ##{tool.barcode} is already checked out!"
    else
      session[:tools] |= [tool.id]
    end
  end

  def store_borrower_in_session
    borrower =
      Participant.find_by_search(params[:participant_search].to_s.strip)
    if borrower
      session[:borrower_id] = borrower.id
    else
      flash.alert = "Andrew ID \"#{params[:participant_search]}\" not found."
    end
  end
end
