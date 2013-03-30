class CheckoutsController < ApplicationController

  def index
    @tool = Tool.find(params[:tool_id])
  end

  def show
    @tool = Tool.find(params[:tool_id])
  end

  def new
    @tool = Tool.find(params[:tool_id])
    @checkout = @tool.checkouts.build
  end

  def create
    @tool = Tool.find(params[:tool_id])
    @checkout = @tool.checkouts.build(params[:checkout])
    @checkout.save!
    redirect_to tool_checkouts_url(@tool)
  end

end
