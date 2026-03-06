# frozen_string_literal: true

require 'csv'

module MembershipsHelper
  # Parses the membership CSV, returning a hash with error if a problem occurs.
  # If successful, creates / updates memberships with "is_in_csv: true" for
  # subsequent repair step
  def parse_membership_csv(csv_file, organization)
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
    'Incorrect Headers! Make sure your file only has one column labeled "Andrew ID" ' \
      'with the Andrew IDs of your builders.'
  end

  # Check whether the membership CSV has the correct headers (andrewid), and
  # if so determines which columns contain them
  def header_columns(csv_headers)
    normalized = csv_headers.compact.map { |h| h.downcase.gsub(' ', '') }
    required = ['andrewid']
    return nil unless normalized.sort == required.sort

    required.index_with { |h| normalized.index(h) }
  end

  def process_csv_row(row, columns, organization)
    eppn = "#{row[columns['andrewid']]}@andrew.cmu.edu"
    p = Participant.find_by(eppn:) || Participant.create!(eppn:)
    m = Membership.find_by(participant: p, organization:)
    if m.nil?
      Membership.create!(participant: p, organization:, is_in_csv: true, is_added_by_csv: true)
    else
      m.update!(is_in_csv: true)
    end
  end
end
