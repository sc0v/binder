class ToolsController < ApplicationController
  load_and_authorize_resource
  
  # GET /tools
  # GET /tools.json
  def index
    unless ( params[:organization_id].blank? )
      @organization = Organization.find(params[:organization_id])
      @tools = Tool.checked_out_by_organization(@organization)
    end

    if (params[:type].blank?)
      @title = "Tools"
      @tools = @tools.just_tools
    elsif (params[:type] == 'hardhats')
      @title = "Hardhats"
      @tools = @tools.hardhats
    elsif (params[:type] == 'radios')
      @title = "Radios"
      @tools = @tools.radios
    elsif (params[:type] == 'out')
      @title = "Checked Out"
      @tools = @tools.just_tools.checked_out
    end

    @tools = @tools.paginate(:page => params[:page]).per_page(20)
  end

  # GET /tools/1
  # GET /tools/1.json
  def show
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
    params.require(:tool).permit(:name, :description, :barcode)
  end
end

