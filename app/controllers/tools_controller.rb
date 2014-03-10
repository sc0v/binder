class ToolsController < ApplicationController
  load_and_authorize_resource
  
  # GET /tools
  # GET /tools.json
  def index
    unless ( params[:organization_id].blank? )
      @organization = Organization.find(params[:organization_id])
      @tools = @tool.checked_out_by_organization(@organization)
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
    end

    @tools = @tools.paginate(:page => params[:page]).per_page(20)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @tools }
    end
  end

  # GET /tools/1
  # GET /tools/1.json
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @tool }
    end
  end

  # GET /tools/new
  # GET /tools/new.json
  def new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @tool }
    end
  end

  # GET /tools/1/edit
  def edit
  end

  # POST /tools
  # POST /tools.json
  def create
    respond_to do |format|
      if @tool.save
        format.html { redirect_to @tool, notice: 'Tool was successfully created.' }
        format.json { render json: @tool, status: :created, location: @tool }
      else
        format.html { render action: "new" }
        format.json { render json: @tool.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /tools/1
  # PUT /tools/1.json
  def update
    respond_to do |format|
      if @tool.update_attributes(tool_params)
        format.html { redirect_to @tool, notice: 'Tool was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @tool.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tools/1
  # DELETE /tools/1.json
  def destroy
    @tool.destroy

    respond_to do |format|
      format.html { redirect_to tools_url }
      format.json { head :no_content }
    end
  end

  private

  def tool_params
    params.require(:tool).permit(:name, :description, :barcode)
  end
end

