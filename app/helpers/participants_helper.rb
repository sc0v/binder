# frozen_string_literal: true
module ParticipantsHelper
  PARTICIPANTS_TABLE_COLUMNS = [
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
      title: 'Andrew Email',
      field: :eppn,
      sorter: 'string',
      headerFilter: 'input',
      headerFilterPlaceholder: 'Search'
    },
    {
      title: 'Signed Waiver',
      field: :signed_waiver?,
      hozAlign: 'center',
      formatter: 'tickCross',
      headerFilter: 'tickCross',
      headerFilterParams: {
        tristate: true
      }},
      {
      title: 'Booth Chair?',
      field: :is_booth_chair?,
      hozAlign: 'center',
      formatter: 'tickCross',
      headerFilter: 'tickCross',
      headerFilterParams: {
        tristate: true
    }}
  ].freeze

  def participants_table_config
    {
      ajaxURL: participants_path(format: :json),
      columns: load_participants_columns,
      dataLoader: false,
      height: '90vh',
      paginationSize: 100,
      placeholder: '<h2>No Participants Found</h2>',
      progressiveLoad: 'load',
      resizableColumnFit: true
    }.to_json
  end

  private

  def load_participants_columns
    attrs = Current.ability.permitted_attributes(:index, Participant)
    PARTICIPANTS_TABLE_COLUMNS.select { |c| attrs.include? c[:field] }
  end
end
