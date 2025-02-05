# frozen_string_literal: true
require 'csv'

module MembershipsHelper
  # Parses the membership CSV, returning a hash with error if a problem occurs.
  # If successful, creates / updates memberships with "is_in_csv: true" for
  # subsequent repair step
  def parse_membership_csv(csv_file, organization)
    begin
      # Make sure the user entered a CSV
      csv = CSV.parse(csv_file.read, headers: true)
      # Make sure CSV has correct headers
      header_columns = header_columns(csv.headers)
      if header_columns.nil?
        return {error: 'Incorrect Headers! Make sure your file only has one column labeled "Andrew ID" with the Andrew IDs of your builders.'}
      end
      # Extract Andrew IDs from each row and create membership in organization
      csv.each do |row|
        eppn = "#{row[header_columns["andrewid"]]}@andrew.cmu.edu"
        p = Participant.find_by(eppn: eppn)
        if p.nil?
          p = Participant.create!(eppn: eppn)
        end
        m = Membership.find_by(participant: p, organization: organization)
        if m.nil?
          # Create memberships that were both in and added by the CSV
          # This means if they are deleted from the CSV they should be removed entirely
          m = Membership.create!({
            participant: p,
            organization: organization,
            is_in_csv: true,
            is_added_by_csv: true,
          })
        else
          # Update memberships to be in the CSV, but not added by the CSV
          # This means if they are deleted from the CSV they not be removed
          m.update!({is_in_csv: true})
        end
      end
      return {error: nil}
    rescue CSV::MalformedCSVError => e
      return {error: 'Malformed CSV! Make sure you submit a CSV file.'}
    end
  end

  private

  # Check whether the membership CSV has the correct headers (andrewid), and
  # if so determines which columns contain them
  def header_columns(csv_headers)
    csv_headers = csv_headers.compact.map { |h| h.downcase.gsub(' ', '') }
    required_headers = ['andrewid']
    required_columns = {}
    # Ensure each required header is present
    required_headers.each do |header|
      if !csv_headers.include? header
        return nil
      end
      required_columns[header] = csv_headers.index header
    end
    # Ensure each present header is required
    csv_headers.each do |header|
      if !required_headers.include? header
        return nil
      end
    end
    return required_columns
  end
end
