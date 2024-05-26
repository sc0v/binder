# frozen_string_literal: true
# format.xlsx { response.headers.merge! excel_export_headers(prefix: 'Organizations') }
module Exportable
  extend ActiveSupport::Concern

  private

  def file_export_headers(
    prefix: 'File',
    body: "-#{DateTime.now.to_fs(:db)}",
    file_extension: nil
  )
    filename = [prefix,body].join('-')
    filename.concat(".#{file_extension}") if file_extension.present?
    { 'Content-Disposition': "attachment; filename=\"#{filename}\"" }
  end

  def excel_export_headers(prefix:)
    file_export_headers(prefix:, file_extension: 'xlsx')
  end
end
