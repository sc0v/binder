# frozen_string_literal: true

class Tools::CheckinController < ApplicationController
  def create
    tool = Tool.find_by(barcode: params[:barcode])
    store_checkin_in_session(tool)
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

  def store_checkin_in_session(tool)
    if tool.nil?
      flash.alert = "No tool found with barcode #{params[:barcode]}"
    elsif !tool.checked_out?
      flash.alert =
        "#{tool.name} ##{tool.barcode} is not currently checked out!"
    else
      session[:checkin_barcode] = params[:barcode]
    end
  end

  def checkin_tool
    checkout = @tool.checkouts.current.first
    if checkout.blank?
      raise CheckoutError, I18n.t('errors.messages.tool_already_checked_in')
    end

    checkout.checked_in_at = Time.zone.now
    checkout.save!
    session[:checkin_barcode] = nil
    redirect_to checkout_tools_path,
                notice: "Tool #{params[:barcode]} successfully checked in."
  end
end
