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
    return if params.dig(:checkout, :organization_id).blank?

    @organization = Organization.find(params[:checkout][:organization_id])
    if session[:tools].blank?
      flash.alert = 'Add at least one tool to checkout.'
      return
    end
    perform_tool_checkout
    redirect_to checkout_tools_path
  end

  def update
    @tool = Tool.find_by(barcode: params[:barcode])
    if @tool.blank?
      redirect_to checkout_tools_path,
                  alert: "Tool #{params[:barcode]} does not exist."
    else
      checkin_tool
    end
  rescue StandardError
    redirect_to checkout_tools_path,
                alert: "Tool #{params[:barcode]} was never checked out."
  end

  private

  def update_tool_session(tool)
    if tool.nil?
      flash.alert =
        "No tool found with that barcode. #{helpers.link_to 'Create it', new_tool_path, class: 'cta'}"
    elsif tool.checked_out?
      flash.alert =
        "#{tool.name} ##{tool.barcode} is already checked out!"
    else
      session[:tools] |= [tool.id]
    end
  end

  def store_borrower_in_session
    borrower = Participant.find_by(search: params[:participant_search])
    if borrower
      session[:borrower_id] = borrower.id
    else
      flash.alert = "Andrew ID \"#{params[:participant_search]}\" not found."
    end
  end

  def perform_tool_checkout
    participant = Participant.find(session[:borrower_id])
    bad_barcodes = []
    session[:tools].each do |tool_id|
      checkout_single_tool(tool_id, participant, bad_barcodes)
    end
    apply_tool_checkout_flash(participant, bad_barcodes)
  end

  def checkout_single_tool(tool_id, participant, bad_barcodes)
    tool = Tool.find(tool_id)
    if Checkout.create!(
         organization: @organization,
         participant:,
         tool:,
         checked_out_at: Time.zone.now
       )
      session[:tools] -= [tool_id]
    else
      bad_barcodes.append(tool.barcode)
    end
  end

  def apply_tool_checkout_flash(participant, bad_barcodes)
    if session[:tools].empty?
      session[:borrower_id] = nil
      flash.notice = "Tools checked out to #{participant.name}"
    else
      flash.alert = "Problem checking out tools #{bad_barcodes.join(', ')}"
    end
  end
end
