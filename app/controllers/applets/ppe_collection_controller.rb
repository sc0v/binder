class Applets::PPECollectionController < ApplicationController
  def index
    if params[:hardhat_barcode]
      return_hardhat
    end
  end

  private

  def return_hardhat
    unless can? :update, Checkout
      redirect_to ppe_collection_path, alert: t('.unauthorized')
      return
    end

    @hardhat = Tool.hardhats.find_by(barcode: params[:hardhat_barcode])
    if @hardhat.blank?
      return redirect_to ppe_collection_path, alert: t('.not_found')
    end
    if @hardhat.checkouts.blank? || @hardhat.checkouts.current.blank?
      return redirect_to ppe_collection_path, alert: t('.already_checked_in')
    end

    @checkout = @hardhat.checkouts.current.first
    @checkout.checkin
    if @checkout.errors.any?
      return redirect_to ppe_collection_path, alert: @checkout.errors.full_messages.join(', ')
    end

    redirect_to ppe_collection_path, notice: t('.checked_in', barcode: params[:hardhat_barcode])
  end
end
