# frozen_string_literal: true
module NotesHelper
  NOTES_TABLE_COLUMNS = [
    {
      title: 'Title',
      field: :title,
      sorter: 'string',
      headerFilter: 'input',
      headerFilterPlaceholder: 'Search'
    },
    {
      title: 'Value',
      field: :value,
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
      title: 'Hidden',
      field: :hidden?,
      hozAlign: 'center',
      formatter: 'tickCross',
      headerFilter: 'tickCross',
      headerFilterParams: {
        tristate: true
      }
    },
    {
      title: 'Participant Name',
      field: :participant_name,
      formatter: 'link',
      formatterParams: {
        urlField: :participant_link
      },
      frozen: true,
      headerFilter: 'input',
      headerFilterPlaceholder: 'Search',
      sorter: 'string'
    },
    {
      title: 'Organization Name',
      field: :organization_name,
      formatter: 'link',
      formatterParams: {
        urlField: :organization_link
      },
      frozen: true,
      headerFilter: 'input',
      headerFilterPlaceholder: 'Search',
      sorter: 'string'
    },
    {
      title: 'Last Change',
      field: :updated_at,
      hozAlign: 'left',
      sorter: 'datetime',
      sorterParams: {
        format: 'yyyy-MM-dd HH:mm (ccc)'
      },
      headerFilter: 'input',
      headerFilterPlaceholder: 'Search'
    }
  ].freeze

  def notes_table_config
    {
      ajaxURL: notes_path(format: :json),
      columns: load_notes_columns,
      dataLoader: false,
      height: '90vh',
      paginationSize: 200,
      placeholder: '<h2>No Notes Found</h2>',
      progressiveLoad: 'load',
      resizableColumnFit: true
    }.to_json
  end

  private

  def load_notes_columns
    attrs = Current.ability.permitted_attributes(:index, Note)
    NOTES_TABLE_COLUMNS.select { |c| attrs.include? c[:field] }
  end
end
