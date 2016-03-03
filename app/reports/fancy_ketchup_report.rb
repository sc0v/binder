# app/reports/fancy_ketchup_report.rb
class FancyKetchupReport < Dossier::Report

  # Or, if you're using ActiveRecord and hate writing SQL:
  def sql
    Organization.where(id: options[:id]).to_sql
  end

  def self.runit
    puts "Ketchup"
  end
end