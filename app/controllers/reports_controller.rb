class ReportsController < ApplicationController

  # GET /reports
  def index
    @reports = []

    Dir.glob("app/reports/*.rb").each{ |file_path|
      # Load the report
      file_name = File.basename(file_path, ".rb")
      class_name = file_name.gsub(/^[a-z0-9]|_[a-z0-9]/){ |a| a.upcase }.gsub(/_/,"")
      require file_name

      # Get the info to show on the reports index page
      report_url = file_name.gsub(/_report/, "")
      report_info = class_name.constantize.binder_report_info

      @reports.push({url: "/reports/#{report_url}",
                     title: report_info[:title],
                     description: report_info[:description],
                     params: report_info[:params]})
      @report_f = {}
    }
  end
end