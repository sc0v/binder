class ToolInventoryToolsController < ApplicationController
  load_and_authorize_resource

  def create
    defaultErrorMsg = 'Could not create the tool.'
    @inventory = ToolInventory.first()

    barcode = params[:tool_inventory_tool][:barcode]
    begin
      barcode = Integer(barcode)
    rescue ArgumentError
      redirect_to tool_inventory_path(@inventory), alert: defaultErrorMsg
      return
    end
    tool_type_id = params[:tool_inventory_tool][:tool_type_id]
    description = params[:tool_inventory_tool][:description]
    tool_check_override = params[:override]

    # We want to let users add tools that have existing IDs after confirmation,
    # So skip barcode uniqueness check if override is set
    if barcode.to_s != tool_check_override
      # Ensure no other tool has the same barcode
      tool_inventory_barcodes = @inventory.tool_inventory_tools.map {|tool| tool.barcode}
      tool_barcodes = Tool.all.map {|tool| tool.barcode}
      if tool_inventory_barcodes.include? barcode
        redirect_to inventory_path(), alert: 'A tool with barcode "' + barcode.to_s + '" has already been added to this inventory.'
        return
      elsif tool_barcodes.include? barcode
        pathParams = {
          default_barcode: barcode,
          default_tool_type_id: tool_type_id,
          default_description: description,
        }
        @existing_tool = Tool.find_by(barcode: barcode)
        redirect_to inventory_path(**pathParams), alert: "A tool with barcode '#{barcode.to_s}' "\
                                         "#{helpers.link_to('already exists', tool_path(@existing_tool))}. "\
                                         "Press 'Add Tool' again to confirm you want to replace the existing tool."
        return
      end
    end

    @tool = @inventory.tool_inventory_tools.new(
      barcode: barcode,
      tool_type_id: tool_type_id,
      description: description,
      active: true)
    if @tool.save
      redirect_to inventory_path(), notice: 'Added Tool!'
    else
      redirect_to inventory_path(), alert: defaultErrorMsg
    end
  end

  def index
    @inventory = ToolInventory.first
    @inventory_tools = @inventory.tool_inventory_tools

    respond_to do |format|
      format.html
      format.json do
        page = params[:page].present? ? params[:page].to_i : 1
        size = params[:size].present? ? params[:size].to_i : 1

        offset = (page - 1) * size
        last_page = @inventory_tools.count / size + (@inventory_tools.count % size == 0 ? 0 : 1)
        tools = @inventory_tools.offset(offset).limit(size)
        data = tools.as_json(
          methods: %i[name description barcode]
        )
        render json: { last_page:, data: }
      end
    end
  end

  def destroy
    inventory = ToolInventory.find params[:tool_inventory_id]
    tool = ToolInventoryTool.find params[:id]
    tool.destroy
    redirect_to inventory_path(), notice: 'Removed Tool!'
  end

  def create_params
    params.require(:tool_inventory_tool).permit(
      :tool_type_id,
      :description
    )
  end
end
