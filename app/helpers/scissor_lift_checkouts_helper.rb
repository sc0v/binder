module ScissorLiftCheckoutsHelper
  SCISSOR_LIFT_CHECKOUTS_TABLE_COLUMNS = [
    {
      title: 'Scissor Lift',
      field: :scissor_lift_name,
      formatter: 'link',
      formatterParams: {
        urlField: :scissor_lift_link
      },
      frozen: true,
      headerFilter: 'input',
      headerFilterPlaceholder: 'Search',
      sorter: 'string'
    },
    {
      title: 'Participant',
      field: :participant_name,
      formatter: 'link',
      formatterParams: {
        urlField: :participant_link
      },
      headerFilter: 'input',
      headerFilterPlaceholder: 'Search',
      sorter: 'string'
    },
    {
      title: 'Organization',
      field: :organization_name,
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
      title: 'Checkin Time',
      field: :checked_in_at,
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
      title: 'Forfeited',
      field: :is_forfeit,
      hozAlign: 'center',
      formatter: 'tickCross',
      headerFilter: 'tickCross',
      headerFilterParams: {
        tristate: true
    }},
  ]

  def scissor_lift_checkouts_table_config
    {
      ajaxURL: scissor_lift_checkouts_path(format: :json),
      columns: SCISSOR_LIFT_CHECKOUTS_TABLE_COLUMNS,
      dataLoader: false,
      height: '90vh',
      placeholder: '<h2>No Scissor Lift Checkouts Found</h2>',
      progressiveLoad: 'load',
      resizableColumnFit: true
    }.to_json
  end
end
