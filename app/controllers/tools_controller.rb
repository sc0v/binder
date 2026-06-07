# frozen_string_literal: true

class ToolsController < ApplicationController
  load_and_authorize_resource

  # Index method with manual pagination using page and size parameters
  # The tools table gets data from here through AJAX, so we keep
  # compute last_page to tell table how many batches it needs
  def index
    tools = tools_for_type(params[:type])

    @json_url = url_for(params.permit(:type, :page, :size).merge(format: :json))

    respond_to do |format|
      format.html { render :index }
      format.json do
        page = params[:page].present? ? params[:page].to_i : 1
        size = params[:size].present? ? params[:size].to_i : 1

        offset = (page - 1) * size
        # Compute last_page as ceil(tool.count / size)
        last_page = (tools.count / size) + ((tools.count % size).zero? ? 0 : 1)
        # Only return the participants in this page
        tools =
          tools
            .accessible_by(Current.ability)
            .ordered_by_name
            .offset(offset)
            .limit(size)
        data = tools.table_attrs.as_json(methods: %i[link])
        data.each do |t|
          t['image_url'] = helpers.asset_path("tool_images/#{t['t_name']}.png")
        end
        render json: { last_page:, data: }
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
      redirect_to tools_path, notice: t('.notice')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @tool.update(tool_params)
    if @tool.valid?
      redirect_to tool_path(@tool), notice: t('.notice')
    else
      redirect_to tool_path(@tool), alert: t('.alert')
    end
  end

  def destroy
    @tool.destroy
    redirect_to tools_path
  end

  private

  def tools_for_type(type)
    case type
    when 'hardhat'
      Tool.hardhats
    when 'radio'
      Tool.radios
    else
      Tool.just_tools
    end
  end

  def tool_params
    params.expect(tool: %i[name description barcode tool_type_id])
  end
end
