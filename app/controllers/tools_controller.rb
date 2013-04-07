class ToolsController < ApplicationController

  def index
    @tools = Tool.not_hardhats.all
  end

  def show
    @tool = Tool.find params[:id]
  end

  def new
    @tool = Tool.new(params[:tool])
  end

  def create

    @tool = Tool.find_by_barcode(params[:tool][:barcode])
    if @tool
      redirect_to new_tool_checkout_url(@tool)
    else

    @tool = Tool.new( params[:tool] )
    @tool.save!
    flash[:success] = "Tool created successfully"
    redirect_to new_tool_url
    end
  rescue
    flash[:error] = "Error creating tool"
    redirect_to new_tool_url
  end

  def edit
    @tool = Tool.find(params[:id])
  rescue
    flash[:error] = "Could not find tool"
    redirect_to tools_url
  end
  
  def update
    @tool = Tool.find(params[:id])
    @tool.update_attributes(params[:tool])
    @tool.save!
    flash[:success] = "Tool updated successfully"
    redirect_to tools_url
  rescue
    flash[:error] = "Tool update failed"
    redirect_to tools_url
  end

end
