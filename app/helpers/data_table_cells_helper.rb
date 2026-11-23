# frozen_string_literal: true

# What goes in each cell of a DataTablesHelper table, by the column's old
# Tabulator formatter
module DataTableCellsHelper
  FORMATTERS = {
    'html' => :data_table_html,
    'link' => :data_table_link_cell,
    'money' => :data_table_money,
    'tickCross' => :data_table_yes_no,
    'datetime' => :data_table_time_cell,
    'textarea' => :data_table_text,
    'imageTooltip' => :data_table_tool
  }.freeze

  def data_table_cell(column, row)
    value = row[column[:field].to_s]
    return data_table_due(value) if column[:field].to_s == 'due_at_countdown'

    formatter = FORMATTERS[column[:formatter]]
    formatter ? send(formatter, value, column, row) : value.to_s
  end

  private

  def data_table_html(value, _column, _row)
    sanitize(
      value.to_s,
      tags: %w[a span],
      attributes: %w[href class aria-label]
    )
  end

  def data_table_money(value, _column, _row) = number_to_currency(value || 0)

  # SQL booleans arrive as 0 and 1, and 0 is true in Ruby
  def data_table_yes_no(value, _column, _row)
    ActiveModel::Type::Boolean.new.cast(value) ? 'Yes' : 'No'
  end

  def data_table_time_cell(value, _column, _row) = data_table_time(value)

  def data_table_text(value, _column, _row)
    simple_format(value.to_s, {}, wrapper_tag: 'span')
  end

  def data_table_link_cell(value, column, row)
    data_table_link(value, row[column.dig(:formatterParams, :urlField).to_s])
  end

  def data_table_link(text, url)
    return text.to_s if url.blank?

    link_to text.to_s, url
  end
end
