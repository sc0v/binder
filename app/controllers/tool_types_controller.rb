# frozen_string_literal: true

class ToolTypesController < ApplicationController
  load_and_authorize_resource

  # GET /tool_types
  # GET /tool_types.json
  def index
    # @tool_types = @tool_types.paginate(:page => params[:page]).per_page(20)
  end

  def show
    @tool_type = ToolType.find(params[:id])
  end
  # GET /tool_types/new
  def new; end

  # GET /tool_types/1/edit
  def edit
    
    end

  # POST /tool_types
  # POST /tool_types.json
  def create
    unless @tool_type.save
      respond_to(@tool_type)
      return
    end

    if params[:from_tools].present?
      redirect_to new_tool_path
      return
    end
    redirect_to tool_types_path
  end

  # PATCH/PUT /tool_types/1
  # PATCH/PUT /tool_types/1.json
  def update
    @tool_type.update(tool_type_params)
    redirect_to tool_types_path
  end

  # DELETE /tool_types/1
  # DELETE /tool_types/1.json
  def destroy
    if @tool_type.tools.count.positive?
      flash[:error] = 'Cannot delete a tool type until all tools of that type are deleted.'
      redirect_to tool_types_path
      return
    end
    @tool_type.destroy
    redirect_to tool_types_path
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def tool_type_params
    params.require(:tool_type).permit(:name)
  end
end
