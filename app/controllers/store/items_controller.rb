# frozen_string_literal: true

class Store::ItemsController < ApplicationController
  # load_and_authorize_resource :store_item # (TODO: Don't commit it like this (uncomment it out))

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
    @store_item.save
    respond_with(@store_item)
  end

  def update
    @store_item = StoreItem.find(params[:id])
    @store_item.update(store_item_params)
    respond_with(@store_item)
  end

  def destroy
    @store_item = StoreItem.find(params[:id])
    @store_item.destroy
    respond_with(@store_item)
  end

  private

  def store_item_params
    params.require(:store_item).permit(:name, :price, :quantity)
  end
end
