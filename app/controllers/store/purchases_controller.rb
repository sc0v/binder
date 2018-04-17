class Store::PurchasesController < ApplicationController

  def add_to_cart
    all_cart_items = StorePurchase.items_in_cart.map { |s| s.store_item }
    item = StoreItem.find params[:id]
    if all_cart_items.include?(item)
      @old_store_purchase = StorePurchase.items_in_cart.where("store_item_id= ?", item.id)
      @old_store_purchase[0].quantity_purchased += 1
      @old_store_purchase[0].price_at_purchase = item.price
      @old_store_purchase[0].store_item = item
      @old_store_purchase[0].save
    else
      @store_purchase = StorePurchase.new
      @store_purchase.quantity_purchased = 1
      @store_purchase.price_at_purchase = item.price
      @store_purchase.store_item = item
      @store_purchase.save
    end
    #respond_with(@store_purchase)
    redirect_to store_url
  end

  def remove_from_cart
    @store_purchase = StorePurchase.find params[:id]
    @store_purchase.destroy
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

  def create
    t = ChargeType.find_by_name("Store Purchase")
    
    StorePurchase.items_in_cart.each do |i|
      c = Charge.new
      c.organization_id = params[:organization_id]      
      c.charge_type = t
      c.description = i.store_item.name + " (x #{i.quantity_purchased})"
      c.receiving_participant_id = params[:charge][:receiving_participant_id]
      c.issuing_participant_id = current_user.participant.id
      c.creating_participant_id = current_user.participant.id
      c.charged_at = Time.now
      c.amount = i.price_at_purchase * i.quantity_purchased
      
      i.charge = c

      if i.store_item.quantity
        i.store_item.quantity = i.store_item.quantity - i.quantity_purchased
      end

      c.save!
      i.save!
      i.store_item.save!
    end

    redirect_to store_url
  end
  

  private

  def store_purchase_params
    params.require(:store_purchase).permit(:quantity_purchased, :store_item_id)
  end
  

end
