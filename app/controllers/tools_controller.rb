class ToolsController < ApplicationController
  load_and_authorize_resource skip_load_resource only: [:create] 
  
  # GET /tools
  # GET /tools.json
  def index
    @title = "Tools"
    @tools = Tool.just_tools.by_barcode.paginate(:page => params[:page]).per_page(10)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @tools }
    end
  end

  # GET /tools/hardhats
  # GET /hardhats.json
  def hardhats_only
    @title = "Hardhats"
    @tools = Tool.hardhats.by_barcode.paginate(:page => params[:page]).per_page(10)

    respond_to do |format|
      format.html { render "index" }
      format.json { render json: @tools }
    end
  end

  # GET /tools/radios
  # GET /radios.json
  def radios_only
    @title = "Radios"
    @tools = Tool.radios.by_barcode.paginate(:page => params[:page]).per_page(10)

    respond_to do |format|
      format.html { render "index" }
      format.json { render json: @tools }
    end
  end


  # GET /tools/1
  # GET /tools/1.json
  def show
    @tool = Tool.find(params[:id])

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
    @tool = Tool.find(params[:id])
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
    @tool = Tool.find(params[:id])

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
    @tool = Tool.find(params[:id])
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

