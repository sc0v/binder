class Applets::PPECollectionController < ApplicationController
  def index
    if params[:hardhat_barcode]
      return_hardhat
    end
  end

  private

  def return_hardhat
    unless can? :update, Checkout
      redirect_to ppe_collection_path, alert: "Not authorized to check in a hardhat."
      return
    end

    @hardhat = Tool.hardhats.find_by(barcode: params[:hardhat_barcode])
    if @hardhat.blank?
      redirect_to ppe_collection_path, alert: "Hardhat not found"
    else
      @checkout = @hardhat.checkouts.current.first
      if @checkout.blank?
        return redirect_to ppe_collection_path, alert: "Hardhat already checked in"
      end

      @checkout.checkin
      if @checkout.errors.any?
        return redirect_to ppe_collection_path, alert: @checkout.errors.full_messages.join(', ')
      end

      redirect_to ppe_collection_path, notice: "Hardhat #{params[:barcode]} successfully checked in."
    end
  end
end
