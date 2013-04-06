class ChargesController < ApplicationController
  def index
  end

  def show
    @charge = Charge.find(params[:id]) 
  end
end
