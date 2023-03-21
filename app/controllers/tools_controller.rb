# frozen_string_literal: true

class ToolsController < ApplicationController

  def index
    #@tools = Tool
    if params[:organization_id].present?
      @organization = Organization.find(params[:organization_id])
      @tools = Tool.checked_out_by_organization(@organization)
    end

    # Filter by tools
    if params[:type_filter].present?
      if params[:type_filter].strip == 'all_tools'
        @tools = Tool.all
        @title = 'Tools (hardhats/radios included)'
      else
        @tool_type = ToolType.find(params[:type_filter])
        @title = @tool_type.name.pluralize
        @tools = @tools.by_type(@tool_type)
        @num_available = Tool.by_type(@tool_type).size - Tool.by_type(@tool_type).checked_out.size
      end
    else
      @tools = Tool.just_tools
      @title = 'Tools'
    end

    # Fitler by inventory status
    return if params[:inventory_filter].blank?

    @tools = @tools.checked_out if params[:inventory_filter].strip == 'checked_out'
    @tools = @tools.checked_in if params[:inventory_filter].strip == 'checked_in'

    # @tools = @tools.paginate(:page => params[:page]).per_page(20)
  end

  # GET /tools/1
  # GET /tools/1.json
  def show; end

  # GET /tools/new
  # GET /tools/new.json
  def new; end

  # GET /tools/1/edit
  def edit; end

  # POST /tools
  # POST /tools.json
  def create
    @tool.save
    respond_with(@tool)
  end

  # PUT /tools/1
  # PUT /tools/1.json
  def update
    @tool.update(tool_params)
    respond_with(@tool)
  end

  # DELETE /tools/1
  # DELETE /tools/1.json
  def destroy
    @tool.destroy
    respond_with(@tool)
  end

  private

  def tool_params
    params.require(:tool).permit(:name, :description, :barcode, :tool_type_id)
  end
end
