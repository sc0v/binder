# frozen_string_literal: true

class ToolsController < ApplicationController
  include Pagy::Backend
  load_and_authorize_resource

  def index()
    type = params[:type] || 'tool'

    tools = Tool.just_tools

    case type
      when 'hardhat'
        tools = Tool.hardhats
      when 'radio'
        tools = Tool.radios
    end

    @pagy, @tools = pagy(tools
      .accessible_by(Current.ability)
      .ordered_by_name, limit: 500, params: ->(params) {
        params.merge(type: type) })

    params.permit!()
    @json_url = url_for(params.merge( format: :json))

    respond_to do |format|
      format.html do
        render :index
      end
      format.json do
        data =
          @tools.table_attrs.as_json(methods: %i[link])
        render json: {last_page: @pagy.pages, data: data}
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
      redirect_to tool_path(@tool), notice: "Updated Tool!"
    else
      redirect_to tool_path(@tool), alert: "Could not update tool."
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
