# frozen_string_literal: true

class Applets::PPECollectionController < ApplicationController
  def index
    return unless params[:hardhat_barcode]

    return_hardhat
  end

  def return_hardhat
    @hardhat = Tool.hardhats.find_by(barcode: params[:hardhat_barcode])
    if @hardhat.nil?
      return redirect_to ppe_collection_path, alert: t('.not_found')
    end
    if no_current_checkout?
      return redirect_to ppe_collection_path, alert: t('.already_checked_in')
    end
    @checkout = @hardhat.checkouts.current.first
    @checkout.checked_in_at = Time.zone.now
    @checkout.save!
    @hardhat.update(status: params[:status]) if params[:status].present?
      
    if @checkout.checked_in_at > Time.zone.local(2026, 4, 14)
      @hardhat.update(status: "Late Return")
    end
    
    redirect_to ppe_collection_path,
                notice: "Hardhat #{params[:barcode]} successfully checked in."
  end

  def no_current_checkout?
    @hardhat.checkouts.blank? || @hardhat.checkouts.current.blank?
  end
end
