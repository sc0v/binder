class ListOrgsReport < Dossier::Report

  # Don't forget to restart server to test changes.
  def self.binder_report_info
    {
        title: "Report to orgs",
        description: "This report helps us display all org info",
        params: [
          {name: :id, type: :text},
          {name: :organization, type: :association, choices: Organization.all}
        ]
    }
  end

  def display_column?(name)
    name == 'short_name' || name == 'name'
  end

  def sql
    Organization.all.to_sql
  end
end