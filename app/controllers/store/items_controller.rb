# frozen_string_literal: true

class Store::ItemsController < ApplicationController
  load_and_authorize_resource :store_item

  def index
    @store_items = StoreItem.order(:name) # .paginate(:page => params[:page]).per_page(20)
  end

  def show
    @store_item = StoreItem.find(params[:id])
  end

  def new
    @store_item = StoreItem.new
  end

  def edit
    @store_item = StoreItem.find(params[:id])
  end

  def create
    @store_item = StoreItem.create(store_item_params)
    begin
      @store_item.save!
      redirect_to store_path, notice: "#{params[:store_item][:name]} successfully added to the store!" 
    rescue
      redirect_to store_path, alert: "#{params[:store_item][:name]} could not be added to the store." 
    end
  end

  def update
    @store_item = StoreItem.find(params[:id])
    begin
      @store_item.update!(store_item_params)
      redirect_to store_path, notice: "#{params[:store_item][:name]} successfully updated!" 
    rescue 
      redirect_to store_path, alert: "#{params[:store_item][:name]} could not be updated." 
    end
  end

  def destroy
    @store_item = StoreItem.find(params[:id])
    @name = @store_item.name
    if StorePurchase.where(store_item: @store_item).length > 0
      redirect_to store_path, alert: "#{@name} is still in the cart!" and return 
    end
    begin
      @store_item.destroy!
      redirect_to store_path, notice: "#{@name} successfully removed from the store!" 
    rescue 
      redirect_to store_path, alert: "#{@name} could not be removed from the store." 
    end
  end

  private

  def store_item_params
    params.require(:store_item).permit(:name, :price)
  end
end
