# frozen_string_literal: true
module ChargesHelper
  CHARGES_TABLE_COLUMNS = [
    {
     frozen: true,
     field: 'show_link',
     formatter: 'html',
     headerSort: false,
   },
    {
     title: 'Charge Type',
     field: :charge_type_name,
     headerFilter: 'input',
     headerFilterPlaceholder: 'Search',
     sorter: 'string'
   },
   {
     title: 'Amount',
     field: :amount,
     formatter: 'money',
     formatterParams: {
      symbol: '$'
     },
     sorter: 'numeric'
   },
   {
     title: 'Organization',
     field: :organization_name,
     headerFilter: 'input',
     headerFilterPlaceholder: 'Search',
     formatter: 'link',
     formatterParams: {
      urlField: 'organization_link',
     },
     sorter: 'string'
   },
   {
     title: 'Description',
     field: :description_truncated,
     formatter: 'textarea',
     sorter: 'string',
     headerFilter: 'input',
     headerFilterPlaceholder: 'Search',
   },
 ]
 
 def charges_table_config
   {
     ajaxURL: charges_path(format: :json),
     columns: CHARGES_TABLE_COLUMNS,
     dataLoader: false,
     height: '90vh',
     paginationSize: 200,
     placeholder: '<h2>No Charges Found</h2>',
     progressiveLoad: 'load',
     resizableColumnFit: true
   }.to_json
 end
 
 private

#  def load_charges_columns
#    attrs = Current.ability.permitted_attributes(:index, Tool)
#    TOOLS_TABLE_COLUMNS.select { |c| attrs.include? c[:field] }
#  end
end
