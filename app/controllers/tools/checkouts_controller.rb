class Tools::CheckoutsController < ApplicationController

  def new

  end

  def add
    session[:tools]||=[]
    tool = Tool.find_by(barcode: params[:barcode])
    if tool.present? && !session[:tools].include?(tool.id)
      session[:tools].append(tool.id)
    else
      flash.alert = "No tool found with that barcode. #{helpers.link_to 'Create it', new_tool_path, class: 'cta'}"
    end
    #redirect_to params[:url]
    #redirect_to tools_path
    redirect_to checkout_tools_path
  end

  def remove
    session[:tools].delete(params[:id].to_i)
    #redirect_to tools_path
    redirect_to checkout_tools_path
  end

  def participant
    borrower = Participant.find_by_search(params[:participant_search])
    if borrower.present?
      session[:borrower_id] = borrower.id
    else
      flash.alert = "Andrew ID \"#{params[:participant_search]}\" not found."
    end
    (redirect_to params[:url] and return) unless !params[:url].present?
    redirect_to checkout_tools_path
  end

  def reset
    session[:borrower_id] = nil
    session[:tools] = nil
    #redirect_to tools_path
    redirect_to checkout_tools_path
  end

  def create
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
    @tool = Tool.find_by(barcode: params[:barcode])
    if @tool.blank?
      redirect_to checkout_tools_path, alert: "Tool #{params[:barcode]} does not exist."
      return
    end

    @checkout = @tool.checkouts.current.first unless @tool.checkouts.blank? || @tool.checkouts.current.blank?
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
