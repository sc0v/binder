# frozen_string_literal: true

class ToolsController < ApplicationController
  load_and_authorize_resource

  # Index method with manual pagination using page and size parameters
  # The tools table gets data from here through AJAX, so we keep
  # compute last_page to tell table how many batches it needs
  def index()
    type = params[:type] || 'tool'

    tools = Tool.just_tools

    case type
      when 'hardhat'
        tools = Tool.hardhats
      when 'radio'
        tools = Tool.radios
    end

    params.permit!()
    @json_url = url_for(params.merge( format: :json))

    respond_to do |format|
      format.html do
        render :index
      end
      format.json do
        page = params[:page].present? ? params[:page].to_i : 1
        size = params[:size].present? ? params[:size].to_i : 1

        offset = (page-1)*size
        # Compute last_page as ceil(tool.count / size)
        last_page = tools.count / size + (tools.count % size == 0 ? 0 : 1)
        # Only return the participants in this page
        tools = tools
          .accessible_by(Current.ability)
          .ordered_by_name
          .offset(offset).limit(size)
        data =
          tools.table_attrs.as_json(methods: %i[link])
        render json: {last_page: , data: }
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
