# frozen_string_literal: true

class ToolInventoryToolsController < ApplicationController
  load_and_authorize_resource

  def index
    @inventory = ToolInventory.first
    @inventory_tools = @inventory.tool_inventory_tools

    respond_to do |format|
      format.html
      format.json { render json: paginated_tools_json }
    end
  end

  def create
    @inventory = ToolInventory.first
    barcode = parse_barcode(params[:tool_inventory_tool][:barcode])
    # rubocop:disable Rails/I18nLocaleTexts
    unless barcode
      return(
        redirect_to tool_inventory_path(@inventory),
                    alert: 'Could not create the tool.'
      )
    end
    # rubocop:enable Rails/I18nLocaleTexts
    return if check_barcode_conflict(barcode)

    save_inventory_tool(barcode)
  end

  def destroy
    ToolInventory.find params[:tool_inventory_id]
    tool = ToolInventoryTool.find params[:id]
    tool.destroy
    redirect_to inventory_path, notice: t('.notice')
  end

  def create_params
    params.expect(tool_inventory_tool: %i[tool_type_id description])
  end

  private

  def paginated_tools_json
    page = page_param
    size = size_param
    offset = (page - 1) * size
    last_page = @inventory_tools.count.fdiv(size).ceil
    tools = @inventory_tools.offset(offset).limit(size)
    data = tools.as_json(methods: %i[name description barcode])
    { last_page:, data: }
  end

  def page_param
    (params[:page].presence || 1).to_i
  end

  def size_param
    (params[:size].presence || 1).to_i
  end

  def parse_barcode(value)
    Integer(value)
  rescue ArgumentError
    nil
  end

  def check_barcode_conflict(barcode)
    return false if barcode.to_s == params[:override]

    check_inventory_barcode(barcode) || check_tool_barcode(barcode)
  end

  def check_inventory_barcode(barcode)
    unless @inventory.tool_inventory_tools.map(&:barcode).include?(barcode)
      return
    end

    redirect_to inventory_path,
                alert:
                  "A tool with barcode \"#{barcode}\" has already been added to this inventory."
    true
  end

  def check_tool_barcode(barcode)
    return unless Tool.all.map(&:barcode).include?(barcode)

    @existing_tool = Tool.find_by(barcode:)
    path_params = {
      default_barcode: barcode,
      default_tool_type_id: params[:tool_inventory_tool][:tool_type_id],
      default_description: params[:tool_inventory_tool][:description]
    }
    redirect_to inventory_path(**path_params),
                alert: tool_conflict_alert(barcode)
    true
  end

  def tool_conflict_alert(barcode)
    "A tool with barcode '#{barcode}' " \
      "#{helpers.link_to('already exists', tool_path(@existing_tool))}. " \
      "Press 'Add Tool' again to confirm you want to replace the existing tool."
  end

  def save_inventory_tool(barcode)
    @tool =
      @inventory.tool_inventory_tools.new(
        barcode:,
        tool_type_id: params[:tool_inventory_tool][:tool_type_id],
        description: params[:tool_inventory_tool][:description],
        active: true
      )
    return redirect_to inventory_path, notice: t('.notice') if @tool.save

    redirect_to inventory_path, alert: 'Could not create the tool.' # rubocop:disable Rails/I18nLocaleTexts
  end
end
