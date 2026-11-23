# frozen_string_literal: true

# Renders the *_TABLE_COLUMNS configs (once Tabulator's) as Web Kilt tables:
# a real <table class="alternate"> with the rows in the page, sortable
# headings, a filter row and a count, sorted and filtered by the Kilt's
# script (cmu-app.js). See Tables in the Kilt's Lists and Tables docs.
module DataTablesHelper
  YES_NO = [['Any', ''], %w[Yes yes], %w[No no]].freeze

  # config: a *_table_config JSON string (for its columns and empty message);
  # rows: hashes with string keys, as the table's JSON endpoint returns them
  def data_table(id:, config:, rows:, noun:)
    columns = JSON.parse(config)['columns'].map(&:with_indifferent_access)
    render 'shared/data_table',
           id:,
           columns:,
           rows: rows.map(&:stringify_keys),
           noun:,
           empty: strip_tags(JSON.parse(config)['placeholder'].to_s).presence
  end

  def data_table_key(column)
    column[:field].to_s.delete('?').presence || 'actions'
  end

  def data_table_sortable?(column)
    column[:headerSort] != false && column[:title].present?
  end

  def data_table_filter(column, id)
    return if column[:headerFilter].blank?

    key = data_table_key(column)
    field_id = "#{id}-filter-#{key}"
    label_tag(field_id, "Filter by #{column[:title]}", class: 'sr-only') +
      data_table_filter_field(
        column[:headerFilter],
        field_id,
        key,
        column[:title]
      )
  end

  def data_table_filter_field(kind, field_id, key, title)
    data = { cmu_filter_column: key }
    if kind == 'tickCross'
      select_tag(nil, options_for_select(YES_NO), id: field_id, data:)
    else
      text_field_tag(nil, nil, id: field_id, placeholder: title, data:)
    end
  end

  def data_table_cell_attrs(column, row)
    classes = []
    classes << 'aligncenter' if column[:hozAlign] == 'center'
    classes << 'num' if column[:formatter] == 'money'
    attrs = { class: classes.join(' ').presence }
    value = row[column[:field].to_s]
    sort = data_table_sort_value(column, value)
    attrs[:data] = { sort_value: sort } unless sort.nil?
    attrs
  end

  def data_table_total(columns, rows)
    return unless columns.any? { |c| c[:bottomCalc] == 'sum' }

    columns.map do |c|
      next '' unless c[:bottomCalc] == 'sum'

      number_to_currency(rows.sum { |r| r[c[:field].to_s].to_f })
    end
  end

  private

  def data_table_sort_value(column, value)
    return if value.nil?

    case column[:sorter]
    when 'datetime', 'time'
      data_table_parse_time(value)&.iso8601
    when 'numeric'
      value.to_f
    end
  end

  def data_table_parse_time(value)
    Time.zone.parse(value.to_s)
  rescue ArgumentError
    nil
  end

  # AP style: Apr. 8, 2027, 12:03 p.m.
  def data_table_time(value)
    time = data_table_parse_time(value)
    return '' unless time

    "#{ap_date(time)}, #{time.year}, #{ap_time(time)}"
  end

  def data_table_due(value)
    time = data_table_parse_time(value)
    return '' unless time
    return tag.span('Overdue', class: 'cmu-pill cmu-pill--amber') if time.past?

    "Due #{data_table_time(value)}"
  end

  # The tool's name links to it; its photo, when there is one, opens
  # enlarged from a Photo link beside the name
  def data_table_tool(name, _column, row)
    link = data_table_link(name, row['link'])
    return link if row['image_url'].blank?

    safe_join([link, data_table_photo(name, row['image_url'])], ' ')
  end

  # A word link, not a thumbnail: thousands of pictures make sorting slow
  def data_table_photo(name, url)
    link_to(
      'Photo',
      url,
      class: 'data-table-photo',
      'aria-label': "Photo of #{name}",
      data: {
        cmu_zoom: ''
      }
    )
  end
end
