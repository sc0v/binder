# frozen_string_literal: true

class ToolsController < ApplicationController
  include Pagy::Backend
  load_and_authorize_resource

  def index
    if params[:tool_type].present?
      case params[:tool_type]
      when 'radio'
        pagy, tools =
          pagy(Tool.just_tools.accessible_by(Current.ability).ordered_by_name)
      end
    else 
      pagy, tools =
        pagy(Tool.just_tools.accessible_by(Current.ability).ordered_by_name)
    end

    @tools = Tool.all
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
        @num_available =
          Tool.by_type(@tool_type).size -
            Tool.by_type(@tool_type).checked_out.size
      end
    else
      #@tools = Tool.just_tools
      @title = 'Tools'
    end

    #return if params[:inventory_filter].blank?

    #@tools = @tools.checked_out if params[:inventory_filter].strip ==
    #  'checked_out'
    #@tools = @tools.checked_in if params[:inventory_filter].strip ==
    #  'checked_in'

    respond_to do |format|
      format.html
      format.json do
        data =
          tools.as_json(
            methods: %i[name link current_organization is_checked_out? current_participant]
          )
        render json: { last_page: pagy.pages, data: }
      end
    end
  end

  def show
  end

  def new
  end

  def edit
  end

  def create
    if @tool.save
      redirect_to tools_path, notice: 'Tool created successfully.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @tool.update(tool_params)
    if @tool.valid?
      redirect_to tools_path
    else
      flash.now[:alert] = t('.alert')
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @tool.destroy
      redirect_to tools_path
    else
      redirect_to tools_path
    end
  end

  private

  def tool_params
    params.require(:tool).permit(:name, :description, :barcode, :tool_type_id)
  end
end
