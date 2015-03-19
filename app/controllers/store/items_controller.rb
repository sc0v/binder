class Store::ItemsController < ApplicationController
  load_and_authorize_resource :store_item
  
  def index
    @store_items = StoreItem.paginate(:page => params[:page]).per_page(20)
  end

  def show
    @store_item = StoreItem.find( params[:id] )
  end

  def new
    @store_item = StoreItem.new
  end

  def edit
    @store_item = StoreItem.find( params[:id] )
  end

  def update
    @store_item = StoreItem.find( params[:id] )
    @store_item.update_attributes(store_item_params)
    respond_with(@store_item)
  end

  def create
    @store_item = StoreItem.create( store_item_params )
    @store_item.save
    respond_with(@store_item)
  end

  private

  def store_item_params
    params.require(:store_item).permit(:name, :price, :quantity)
  end
end
