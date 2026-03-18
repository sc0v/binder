# frozen_string_literal: true

module ShiftsHelper
  def current?(shift)
    shift.starts_at <= Time.zone.now and shift.ends_at > Time.zone.now
  end

  # Parses the shift CSV, returning a hash with error if a problem occurs.
  def parse_shift_csv(csv_file, organization)
    csv = CSV.parse(csv_file.read, headers: true)
    columns = header_columns(csv.headers)
    return { error: invalid_headers_message } if columns.nil?

    csv.each { |row| process_csv_row(row, columns, organization) }
    { error: nil }
  rescue CSV::MalformedCSVError
    { error: 'Malformed CSV! Make sure you submit a CSV file.' }
  end

  private

  def invalid_headers_message
    'Incorrect Headers! Make sure your CSV has columns: ' \
      '"starts_at", "ends_at", "required_number_of_participants", "description", "shift_type"'
  end

  # Check whether the shift CSV has the correct headers, and
  # if so determines which columns contain them
  def header_columns(csv_headers)
    normalized = csv_headers.compact.map { |h| h.downcase.gsub(' ', '') }
    required = %w[starts_at ends_at required_number_of_participants description shift_type]
    return nil unless (required - normalized).empty?

    required.index_with { |h| normalized.index(h) }
  end

  def process_csv_row(row, columns, organization)
    shift_type = ShiftType.find_by(name: row[columns['shift_type']])
    return if shift_type.nil?

    Shift.create!(
      andrew_id: row[columns['andrew_id']],
      starts_at: row[columns['starts_at']],
      ends_at: row[columns['ends_at']],
      description: row[columns['description']],
      shift_type:,
      organization:
    )
  end
end
