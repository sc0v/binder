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

    if @tool.is_checked_out
      @checkout = @tool.checkouts.current[0]
      @checkout.checked_in_at = Time.now
      @checkout.save!
      
      @checkout = @tool.checkouts.build(participant: participant, tool: @tool, checked_out_at: Time.now)
      @checkout.save!
      redirect_to tool_checkouts_url(@tool)
    else
      @checkout = @tool.checkouts.build(participant: participant, tool: @tool, checked_out_at: Time.now)
      @checkout.save!
      redirect_to tool_checkouts_url(@tool)
    end
  end

  def checkin
    @tool = Tool.find_by_barcode params[:barcode]
    flash[:error] = "Tool not found" unless @tool

    if @tool and @tool.is_checked_out
      @checkout = @tool.checkouts.current[0]
      @checkout.checked_in_at = Time.now
      @checkout.save!
      flash[:notice] = "Successfully checked in #{@tool.name}"
    end
  end

end
