class ListBuildersReport < Dossier::Report

  def self.binder_report_info
    {
        title: "List all participants that are builders",
        description: "List all participants that are builders. This includes anyone belonging to a
                      Fraternity, Sorority, Independent, Blitz, or Concessions organization."
    }
  end

  def format_header(column_name)
    return 'Andrew ID' if column_name == 'andrewid'
    return 'Organization' if column_name == 'name'
    column_name
  end

  def sql
    Organization.joins(:participants).only_categories(%w[Fraternity Sorority Independent Blitz Concessions])
        .select('organizations.name', 'andrewid').reorder('organizations.name').to_sql
  end

end