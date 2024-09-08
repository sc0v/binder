# frozen_string_literal: true
module ToolInventoryHelper
  TOOL_INVENTORY_TABLE_COLUMNS = [
     {
      title: 'Name',
      field: :name,
      formatter: 'link',
      formatterParams: {
        urlField: :link
      },
      frozen: true,
      headerFilter: 'input',
      headerFilterPlaceholder: 'Search',
      sorter: 'string'
    },
    {
      title: 'Description',
      field: :description,
      sorter: 'string',
      headerFilter: 'input',
      headerFilterPlaceholder: 'Search'
    },
    {
      title: 'Barcode',
      field: :barcode,
      sorter: 'string',
      headerFilter: 'input',
      headerFilterPlaceholder: 'Search'
    },
  ]
  
  def tool_inventory_table_config
    {
      ajaxURL: tool_inventory_tool_inventory_tools_path(ToolInventory.first, format: :json),
      columns: load_tool_inventory_columns,
      dataLoader: false,
      height: '90vh',
      paginationSize: 200,
      placeholder: '<h2>Nothing Added to Inventory</h2>',
      progressiveLoad: 'load',
      resizableColumnFit: true
    }.to_json
  end
  
  private

  def load_tool_inventory_columns
    # TODO: Change to Reflect Actual Permissions
    TOOL_INVENTORY_TABLE_COLUMNS
  end

  def cart_icon
    "<i class='fa fa-print'></i>"
  end
end
