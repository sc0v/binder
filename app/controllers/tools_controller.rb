class ToolsController < ApplicationController
  load_and_authorize_resource skip_load_resource only: [:create] 
  before_action :set_tool, only: [:show, :edit, :update, :destroy]
  
  # GET /tools
  # GET /tools.json
  def index
    unless ( params[:organization_id].blank? )
      @organization = Organization.find(params[:organization_id])
      @tools = Tool.checked_out_by_organization(@organization)
    else
      @tools = Tool.all
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
    @tool = Tool.new

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
    @tool = Tool.new(tool_params)

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
      if @tool.update(tool_params)
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
  def set_tool
    @tool = Tool.find(params[:id])
  end

  def tool_params
    params.require(:tool).permit(:name, :description, :barcode)
  end
  # User permissions need to be added to the following 2 methods
  # def checkout
  #   @tool = Tool.find(params[:id])

  #   if(!@tool.is_checked_out?)
  #       @checkout = Checkout.new
  #       @checkout.checked_in_at = nil
  #       @checkout.checked_out_at = Date.today
  #       @checkout.tool = @tool
  #       @checkout.participant = nil
  #       @checkout.organization = nil
  #       @checkout.save!

  #       redirect_to @tool
  #   else
  #       flash[:notice] = "#{@tool.name} was not checked out because it has been previously checked out."
  #       redirect_to @tool
  #   end
  # end


  # def checkin
  #   @tool = Tool.find(params[:id])

  #   if(@tool.is_checked_out?)
  #       @current = @tool.checkouts.current.pluck(:id)
  #       @checkout = Checkout.find_by_id(@current)

  #       @checkout.checked_in_at = Date.today
  #       @checkout.save!

  #       redirect_to @tool
  #   else
  #       flash[:notice] = "#{@tool.name} was not checked in because it was not checked out."
  #       redirect_to @tool
  #   end
  # end
end

