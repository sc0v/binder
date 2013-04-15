class ToolsController < ApplicationController

  def lookup
    # Process request if barcode is present
    if params[:tool] and params[:tool][:barcode]
      tool = Tool.find_by_barcode params[:tool][:barcode]
      
      if tool.nil? # tool does not exist
        redirect_to new_tool_url params[:tool]
        
      elsif session[:return_url] and session[:return_url] != ''
        session[:tool_id] = tool
        redirect_to session[:return_url]

      else
        redirect_to tool_url tool

      end
    end # if params[:tool] and params[:tool][:barcode]
  end


  def index
    if params[:type] == "hardhats"
      @title = "Hardhats"
      @tools = Tool.hardhats.all
    elsif params[:type] == "radios"
      @title = "Radios"
      @tools = Tool.radios.all
    else
      @title = "Tools"
      @tools = Tool.just_tools.all
    end
  end


  def show
    @tool = Tool.find params[:id]
  end


  def new
    # Perform a barcode lookup and then populate
    # the new tool's details
    unless params[:barcode] and params[:barcode] != ''
      render 'lookup'
    else
      if params[:tool]
        params[:tool][] << params[:barcode]
        @tool = Tool.new params[:tool]
      else
        @tool = Tool.new barcode: params[:barcode]
      end
      render 'new'
    end
  end


  def create
    # Create a new tool
    tool = Tool.new params[:tool]
    tool.save!
    flash[:success] = "Successfully created tool"

    # Use a form parameter to determine whether to 
    # add multiple tools sequentially or
    # to go directly to the new tool's checkouts
    session[:return_url] = params[:return_url]

    # Create another tool or go to the newest tool's
    # checkout page
    if session[:return_url]
      redirect_to session[:return_url]
    else
      redirect_to new_tool_checkout_url tool
    end

  rescue
    flash[:error] = "Error creating tool"
    redirect_to new_tool_url
  end


  def edit
    @tool = Tool.find params[:id]
  rescue
    flash[:error] = "Tool does not exist"
    redirect_to tools_url
  end
  

  def update
    tool = Tool.find params[:id]
    tool.update_attributes params[:tool]
    tool.save!
    flash[:success] = "Successfully updated tool"
    redirect_to tools_url
  rescue
    flash[:error] = "Error updating tool"
    redirect_to tools_url
  end

end
