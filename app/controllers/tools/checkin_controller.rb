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

  def get_checkin_tool_summary(org, remaining)
    session[:checkin_barcode] = nil
    session[:checkin_summary] = {
      name: @tool.name,
      barcode: @tool.barcode,
      org: org.short_name,
      remaining: remaining
    }
  end

  def org_and_remaining_tools
    org = @tool.current_organization
    remaining = Tool.checked_out_by_organization(org).where(tool_type: @tool.tool_type).count - 1
    { org: org, remaining: remaining }
  end

  def process_checkout
    checkout = @tool.checkouts.current.first
    if checkout.blank?
      raise CheckoutError, I18n.t('errors.messages.tool_already_checked_in')
    end

    checkout.checked_in_at = Time.zone.now
    checkout.save!
  end

  def checkin_tool
    data = org_and_remaining_tools
    process_checkout
    get_checkin_tool_summary(data[:org], data[:remaining])
    redirect_to checkout_tools_path,
                notice: "Tool #{params[:barcode]} successfully checked in."
  end
end
