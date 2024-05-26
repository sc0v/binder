# frozen_string_literal: true
module ToolsHelper
  TOOLS_FUNCTION_COLUMNS = [
    {
      formatter: 'cart_icon',
      resizableColumnFit: false,
      width:40,
      hozAlign:"center",
      cellClick:
        'function(e, cell){
                      alert("Printing row data for: " + cell.getRow().getData().name)
       }'
     }, 

  ]
  
  TOOLS_TABLE_COLUMNS = [
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
    {
      title: 'Checked Out',
      field: :is_checked_out?,
      hozAlign: 'center',
      formatter: 'tickCross',
      headerFilter: 'tickCross',
      headerFilterParams: {
        tristate: true
      }},
    {
      title: 'Current Organization',
      field: :current_organization,
      sorter: 'string',
      headerFilter: 'input',
      headerFilterPlaceholder: 'Search'
    },
    {
      title: 'Current Participant',
      field: :current_participant,
      sorter: 'string',
      headerFilter: 'input',
      headerFilterPlaceholder: 'Search'
    },
  ]
  
  def tools_table_config
    {
      ajaxURL: tools_path(format: :json),
      columns: load_tools_columns,
      dataLoader: false,
      height: '90vh',
      paginationSize: 200,
      placeholder: '<h2>No Tools Found</h2>',
      progressiveLoad: 'load',
      resizableColumnFit: true
    }.to_json
  end
  
  private

  def load_tools_columns
    attrs = Current.ability.permitted_attributes(:index, Tool)
    TOOLS_FUNCTION_COLUMNS + TOOLS_TABLE_COLUMNS.select { |c| attrs.include? c[:field] }
  end

  def cart_icon
    "<i class='fa fa-print'></i>"
  end
end
