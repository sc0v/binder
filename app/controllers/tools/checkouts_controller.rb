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
      flash.alert = "Not authorized to check out tools."
      redirect_to checkout_tools_path
      return
    end

    @organization = Organization.find_by(id: params.dig(:checkout, :organization_id))
    tool_ids = Array(session[:tools])
    participant = Participant.find_by(id: session[:borrower_id])
    batch_result = Checkout.checkout_batch(
      organization: @organization,
      participant: participant,
      tool_ids: tool_ids
    )

    session[:tools] = batch_result[:remaining_ids]
    bad_barcodes = batch_result[:failed].map { |checkout| checkout.tool&.barcode }.compact

    if batch_result[:failed].empty? && session[:tools].empty?
      session[:borrower_id] = nil
      flash.notice = "Tools checked out to #{participant&.name}"
    else
      failed_messages = batch_result[:failed].flat_map { |checkout| checkout.errors.full_messages }
      message = failed_messages.presence || ["Problem checking out tools #{bad_barcodes.join(', ')}"]
      flash.alert = message.join(', ')
      #redirect_to tools_path
    end
    redirect_to checkout_tools_path
  end

  def checkin
    unless can? :update, Checkout
      redirect_to checkout_tools_path, alert: "Not authorized to check in tools."
      return
    end

    @tool = Tool.find_by(barcode: params[:barcode])
    if @tool.blank?
      redirect_to checkout_tools_path, alert: "Tool #{params[:barcode]} does not exist."
      return
    end

    @checkout = @tool.checkouts.current.first
    if @checkout.blank?
      redirect_to checkout_tools_path, alert: "Tool #{params[:barcode]} was never checked out."
      return
    end

    @checkout.checkin
    if @checkout.errors.any?
      redirect_to checkout_tools_path, alert: @checkout.errors.full_messages.join(', ')
      return
    end

    redirect_to checkout_tools_path, notice: "Tool #{params[:barcode]} successfully checked in."
  end
end
