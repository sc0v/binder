class ToolTypesController < ApplicationController
  load_and_authorize_resource

  # GET /tool_types
  # GET /tool_types.json
  def index
  end

  # GET /tool_types/1
  # GET /tool_types/1.json
  def show
  end

  # GET /tool_types/new
  def new
  end

  # GET /tool_types/1/edit
  def edit
  end

  # POST /tool_types
  # POST /tool_types.json
  def create
    @tool_type.save
    respond_with(@tool_type)
  end

  # PATCH/PUT /tool_types/1
  # PATCH/PUT /tool_types/1.json
  def update
    @tool_type.update_attributes(tool_type_params)
    respond_with(@tool_type)
  end

  # DELETE /tool_types/1
  # DELETE /tool_types/1.json
  def destroy
    if(@tool_type.tools.count > 0)
      flash[:error] = 'Cannot delete a tool type until all tools of that type are deleted.'
      redirect_to tool_types_url
      return
    end
    @tool_type.destroy
    respond_with(@tool_type)
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def tool_type_params
      params.require(:tool_type).permit(:name)
    end
end
