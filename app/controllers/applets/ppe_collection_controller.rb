# frozen_string_literal: true

class Applets::PPECollectionController < ApplicationController
  def index
    return unless params[:hardhat_barcode]

    return_hardhat
  end

  def return_hardhat
    @hardhat = Tool.hardhats.find_by(barcode: params[:hardhat_barcode])
    if @hardhat.nil?
      redirect_to ppe_collection_path, alert: t('.not_found')
    else
      unless @hardhat.checkouts.blank? || @hardhat.checkouts.current.blank?
        @checkout = @hardhat.checkouts.current.first
      end
      if @hardhat.checkouts.blank? || @hardhat.checkouts.current.blank?
        return(redirect_to ppe_collection_path, alert: t('.already_checked_in'))
      end

      @checkout.checked_in_at = Time.zone.now
      @checkout.save!

      redirect_to ppe_collection_path,
                  notice: "Hardhat #{params[:barcode]} successfully checked in."
    end
  end
end
