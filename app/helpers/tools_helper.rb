# frozen_string_literal: true
module ToolsHelper
  TOOLS_TABLE_COLUMNS = [
     {
      title: 'Name',
      field: :t_name,
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
      field: :t_is_checked_out,
      hozAlign: 'center',
      formatter: 'tickCross',
      headerFilter: 'tickCross',
      headerFilterParams: {
        tristate: true
      }},
    {
      title: 'Current Organization',
      field: :t_organization_name,
      sorter: 'string',
      headerFilter: 'input',
      headerFilterPlaceholder: 'Search'
    },
    {
      title: 'Current Participant',
      field: :t_participant_name,
      sorter: 'string',
      headerFilter: 'input',
      headerFilterPlaceholder: 'Search'
    },
  ]

  def tools_table_config
    {
      ajaxURL: @json_url,
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
    TOOLS_TABLE_COLUMNS.select { |c| attrs.include? c[:field] }
  end
end
