# frozen_string_literal: true

class Tools::CheckoutsController < ApplicationController
  before_action :require_checkin_permission, only: :checkin
  before_action :load_checkin_resources, only: :checkin

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

    process_checkout_batch
    redirect_to checkout_tools_path
  end

  def checkin
    @checkout.checkin
    if @checkout.errors.any?
      redirect_to checkout_tools_path, alert: @checkout.errors.full_messages.join(', ')
      return
    end

    redirect_to checkout_tools_path, notice: "Tool #{params[:barcode]} successfully checked in."
  end

  private

  def update_tool_session(tool)
    if tool
      session[:tools] |= [tool.id]
    else
      flash.alert = "No tool found with that barcode. #{helpers.link_to 'Create it', new_tool_path, class: 'cta'}"
    end
  end

  def store_borrower_in_session
    borrower = Participant.search(params[:participant_search])
    if borrower
      session[:borrower_id] = borrower.id
    else
      flash.alert = "Andrew ID \"#{params[:participant_search]}\" not found."
    end
  end

  def require_checkin_permission
    return if can? :update, Checkout

    redirect_to checkout_tools_path, alert: t('tools.checkouts.checkin.unauthorized')
  end

  def load_checkin_resources
    @tool = Tool.find_by(barcode: params[:barcode])
    unless @tool
      redirect_to checkout_tools_path, alert: "Tool #{params[:barcode]} does not exist."
      return
    end

    @checkout = @tool.checkouts.current.first
    redirect_to checkout_tools_path, alert: "Tool #{params[:barcode]} was never checked out." unless @checkout
  end

  def process_checkout_batch
    participant = Participant.find_by(id: session[:borrower_id])
    batch_result = Checkout.checkout_batch(
      organization: Organization.find_by(id: params.dig(:checkout, :organization_id)),
      participant: participant,
      tool_ids: Array(session[:tools])
    )
    apply_batch_results(batch_result, participant)
  end

  def apply_batch_results(batch_result, participant)
    session[:tools] = batch_result[:remaining_ids]
    if batch_result[:failed].empty? && session[:tools].empty?
      flash_checkout_success(participant)
    else
      flash_checkout_failure(batch_result[:failed])
    end
  end

  def flash_checkout_success(participant)
    session[:borrower_id] = nil
    flash.notice = "Tools checked out to #{participant&.name}"
  end

  def flash_checkout_failure(failed_checkouts)
    bad_barcodes = failed_checkouts.map { |c| c.tool&.barcode }.compact
    messages = failed_checkouts.flat_map { |c| c.errors.full_messages }
    flash.alert = (messages.presence || ["Problem checking out tools #{bad_barcodes.join(', ')}"]).join(', ')
  end
end
