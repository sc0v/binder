class Store::PurchasesController < ApplicationController

  def add_to_cart
    @store_purchase = StorePurchase.new
    item = StoreItem.find params[:id]
    @store_purchase.quantity_purchased = 1
    @store_purchase.price_at_purchase = item.price
    @store_purchase.store_item = item
    @store_purchase.save

    #respond_with(@store_purchase)
    redirect_to store_url
  end

  def new
    @charge = Charge.new
  end
  
  def update
    @store_purchase = StorePurchase.find params[:id]
    @store_purchase.update_attributes(store_purchase_params)
    if @store_purchase.quantity_purchased <= 0
      @store_purchase.destroy
    end
    # TODO: respond_with
    redirect_to store_url
  end

  def choose_organization
    @participant = Participant.find_by_andrewid(params['card-number-input'])

    respond_to do |format|
      format.html { render "choose_organization", :participant => @participant }
 #     format.json { render json: @checkouts }
    end
  end

  def create
    c = Charge.new
    t = ChargeType.find_by_name("Store Purchase")

    c.organization_id = params[:organization_id]
    c.amount = 
    c.charge_type = t
    c.description = "Store purchase"
    c.receiving_participant_id = params[:participant_id]
    c.issuing_participant_id = 14
    c.amount = 0
    c.charged_at = Time.now
    # TODO: creating part
    # c.creating_participant = ""

    c.save!

    StorePurchase.items_in_cart.each do |i|
      i.charge = c
      c.amount = c.amount + i.price_at_purchase * i.quantity_purchased
      i.store_item.quantity = i.store_item.quantity - i.quantity_purchased
      i.store_item.save
      i.save
    end
    c.save!
    redirect_to store_url
  end
  

  private

  def store_purchase_params
    params.require(:store_purchase).permit(:quantity_purchased, :store_item_id)
  end
  

end
