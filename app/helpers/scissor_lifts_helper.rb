module ScissorLiftsHelper
  SCISSOR_LIFTS_TABLE_COLUMNS = [
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
      title: 'Checked Out',
      field: :is_checked_out?,
      hozAlign: 'center',
      formatter: 'tickCross',
      headerFilter: 'tickCross',
      headerFilterParams: {
        tristate: true
      }
    },
    {
      title: 'Current Organization',
      field: :current_organization,
      sorter: 'string',
      headerFilter: 'input',
      headerFilterPlaceholder: 'Search'
    },
    {
      title: 'Checkout Time',
      field: :checked_out_at,
      formatter: 'datetime',
      formatterParams: {
        inputFormat:"yyyy-MM-dd'T'HH:mm:ss.SSSZZ",
        outputFormat: 'f',
        invalidPlaceholder: true
      },
      sorter: 'datetime',
      sorterParams: {
        format: "yyyy-MM-dd'T'HH:mm:ss.SSSZZ",
        alignEmptyValues: "bottom",
      },
    },
    {
      title: 'Time Due',
      field: :due_at,
      formatter: 'datetime',
      formatterParams: {
        inputFormat:"yyyy-MM-dd'T'HH:mm:ss.SSSZZ",
        outputFormat: 'f',
        invalidPlaceholder: true
      },
      sorter: 'datetime',
      sorterParams: {
        format: "yyyy-MM-dd'T'HH:mm:ss.SSSZZ",
        alignEmptyValues: "bottom",
      },
    },
  ]

  def scissor_lifts_table_config
    {
      ajaxURL: scissor_lifts_path(format: :json),
      columns: load_scissor_lifts_columns,
      dataLoader: false,
      height: '90vh',
      paginationSize: 200,
      placeholder: '<h2>No Scissor Lifts Found</h2>',
      progressiveLoad: 'load',
      resizableColumnFit: true
    }.to_json
  end

  private 

  def load_scissor_lifts_columns 
    SCISSOR_LIFTS_TABLE_COLUMNS
  end
end
