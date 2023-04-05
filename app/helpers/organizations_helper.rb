# frozen_string_literal: true
module OrganizationsHelper
  TABLE_COLUMNS = [
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
      title: 'Short Name',
      field: :short_name,
      headerFilter: 'input',
      headerFilterPlaceholder: 'Search',
      sorter: 'string'
    },
    {
      title: 'Category',
      field: :category_name,
      sorter: 'string',
      headerFilter: 'input',
      headerFilterPlaceholder: 'Search'
    },
    {
      title: 'Building',
      field: :building?,
      hozAlign: 'center',
      formatter: 'tickCross',
      headerFilter: 'tickCross',
      headerFilterParams: {
        tristate: true
      }
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
    },
    { title: 'Structural Queue', hozAlign: 'left' },
    { title: 'Electrical Queue', hozAlign: 'left' },
    { title: 'Downtime', hozAlign: 'left' }
  ].freeze

  def table_config
    {
      ajaxURL: organizations_path(format: :json),
      columns:,
      dataLoader: false,
      height: '90vh',
      paginationSize: 25,
      placeholder: '<h2>No Organizations Found</h2>',
      progressiveLoad: 'scroll',
      resizableColumnFit: true
    }.to_json
  end

  private

  def columns
    attrs = Current.ability.permitted_attributes(:index, Organization)
    TABLE_COLUMNS.select { |c| attrs.include? c[:field] }
  end
end
