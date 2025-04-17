require 'csv'
require 'zip'

module Exporter
  # Generate a CSV based on some collection, with one row for each record
  # in the collection
  #
  # collection: the collection to generate a CSV based on
  # headers: List of string headers for the CSV
  # footers: List of string footers for the CSV (such as a total at the bottom)
  # generate_row: a function that takes in a record and returns an array of cells
  #               the row should have
  def self.generate_csv(collection, headers, generate_row, footers)
    CSV.generate do |csv|
      if headers != []
        csv << headers
      end
      collection.each do |record|
        csv << generate_row.call(record)
      end
      if footers != []
        csv << footers
      end
    end
  end

  # Generate a zip with some number of files
  def self.generate_zip(files)
    zip_stream = Zip::OutputStream.write_buffer do |zip|
      files.each do |filename, file|
        zip.put_next_entry(filename)
        zip.write file  
      end
    end

    zip_stream.rewind
    zip_stream.read
  end
end