class ToolInventoryController < ApplicationController
  def show
    @inventory = ToolInventory.first
    @inventory_tools = @inventory.tool_inventory_tools.all

    @default_tool_type = params[:default_tool_type_id].to_i
  end

  # Method to Merge Tool Inventory Tools in with the actual tools
  def complete
    inventory = ToolInventory.find(params[:tool_inventory_id])
    @inventory_tools = inventory.tool_inventory_tools.all
    # Delete or update all pre-exisiting tools (except hardhats and radios)
    Tool.just_tools.all.each do |tool|
      inventory_tool = @inventory_tools.find_by(barcode: tool.barcode)
      if inventory_tool != nil && inventory_tool.equal_to_tool(tool)
        # Merge old and new Tools
        if tool.update(description: inventory_tool.description)
          ToolInventoryTool.delete(inventory_tool)
        end
      else
        # Delete old Tool
        tool.delete
      end
    end
    # Add all tool inventory tools without a corresponding existing tool
    @inventory_tools.each do |inventory_tool|
      if Tool.create({
        barcode: inventory_tool.barcode,
        tool_type: inventory_tool.tool_type,
        description: inventory_tool.description,
        active: inventory_tool.active
      })
        ToolInventoryTool.delete(inventory_tool)
      end
    end
    redirect_to inventory_path()
  end
end
