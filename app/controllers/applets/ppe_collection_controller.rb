class Applets::PPECollectionController < ApplicationController
  def index
    if params[:hardhat_barcode]
      return_hardhat
    end
  end

  def return_hardhat
    @hardhat = Tool.hardhats.find_by(barcode: params[:hardhat_barcode])
    if @hardhat.nil?
      redirect_to ppe_collection_path, alert: "Hardhat not found"
    else
      @checkout = @hardhat.checkouts.current.first unless @hardhat.checkouts.blank? || @hardhat.checkouts.current.blank?
      if @hardhat.checkouts.blank? || @hardhat.checkouts.current.blank?
        return redirect_to ppe_collection_path, alert: "Hardhat already checked in"
      end
      @checkout.checked_in_at = Time.zone.now
      @checkout.save!

      redirect_to ppe_collection_path, notice: "Hardhat #{params[:barcode]} successfully checked in."
    end
  end
end
