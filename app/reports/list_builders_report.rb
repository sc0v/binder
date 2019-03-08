class ListBuildersReport < Dossier::Report
  # Don't forget to restart server to test changes to reports.

  def self.binder_report_info
    {
        title: "List all participants that are builders",
        description: "List all participants that are builders. This includes anyone belonging to a
                      Fraternity, Sorority, Independent, Blitz, or Concessions organization."
    }
  end

  def sql
    Organization.joins(:participants).only_categories(%w[Fraternity Sorority Independent Blitz Concessions])
        .select('organizations.name AS \'Organization\'', 'andrewid AS \'Andrew ID\'',
                'phone_number AS \'Phone Number\'')
        .reorder('organizations.name').to_sql

  end

end