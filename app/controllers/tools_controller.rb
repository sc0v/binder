class ToolsController < ApplicationController
  load_and_authorize_resource
  
  # GET /tools
  # GET /tools.json
  def index
    unless params[:organization_id].blank?
      @organization = Organization.find(params[:organization_id])
      @tools = Tool.checked_out_by_organization(@organization)
    end

    # Filter by tools
    if params[:type_filter].present?
      if params[:type_filter].strip == 'all_tools'
        @tools = Tool.all
        @title = "Tools (hardhats/radios included)"
      else
        @tool_type = ToolType.find(params[:type_filter])
        @title = @tool_type.name.pluralize
        @tools = Tool.by_type(@tool_type)
        @waitlist = @tool_type.tool_waitlists.by_wait_start_time
        @num_available = @tools.size - @tools.checked_out.size
      end
    else
      @tools = Tool.just_tools
      @title = "Tools"
    end

    # Fitler by inventory status
    if params[:inventory_filter].present? && params[:inventory_filter].strip == 'checked_out'
      @tools = @tools.checked_out
    end

    @tools = @tools.paginate(:page => params[:page]).per_page(20)
  end

  # GET /tools/1
  # GET /tools/1.json
  def show
    @waitlist = @tool.tool_type.tool_waitlists.by_wait_start_time
  end

  # GET /tools/new
  # GET /tools/new.json
  def new
  end

  # GET /tools/1/edit
  def edit
  end

  # POST /tools
  # POST /tools.json
  def create
    @tool.save
    respond_with(@tool)
  end

  # PUT /tools/1
  # PUT /tools/1.json
  def update
    @tool.update_attributes(tool_params)
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

