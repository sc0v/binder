# frozen_string_literal: true

class ToolsController < ApplicationController
  include Pagy::Backend
  load_and_authorize_resource

  def index
    # if params[:organization_id].present?
    #   @organization = Organization.find(params[:organization_id])
    #   @tools = Tool.just_tools.checked_out_by_organization(@organization)
    # else
    #   @tools = Tool.just_tools.accessible_by(Current.ability).ordered_by_name
    # end

    # Paginate a lot of records at a time since something seems to be reloaded
    # each round of pagination so wanted to minimize the number of rounds
    pagy, @tools = pagy(Tool.just_tools.accessible_by(Current.ability).ordered_by_name, limit: 500)

    respond_to do |format|
      format.html
      format.json do
        data =
          @tools.table_attrs.as_json(methods: %i[link])
        render json: {last_page: pagy.pages, data: }
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
