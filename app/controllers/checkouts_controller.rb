class CheckoutsController < ApplicationController

  def index
    unless params[:tool_id]
      render 'lookup'
    else
      @tool = Tool.find(params[:tool_id])
    end
  end

  def show
    @tool = Tool.find(params[:tool_id])
  end

  def new
    @tool = Tool.find(params[:tool_id])
    #@checkout = @tool.checkouts.build
  end

  def create
    @tool = Tool.find(params[:tool_id])
    participant = Participant.find_by_card params[:card_number]
    @checkout = @tool.checkouts.build(participant: participant, tool: @tool, checked_out_at: Time.now)
    @checkout.save!
    redirect_to tool_checkouts_url(@tool)
  end

  

end
