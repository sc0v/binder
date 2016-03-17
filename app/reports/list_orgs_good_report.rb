class ListOrgsGoodReport < Dossier::Report

  def self.binder_report_info
    {
        title: "Report to orgs good",
        description: "This report helps us display all org info",
        params: [
          {name: :id, type: :text},
          {name: :organization, type: :select, choices: Organization.all.map{|o| [o.name, o.id]}},
          {name: :should_show, type: :checkbox}
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