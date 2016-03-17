class ListAllUsersReport < Dossier::Report

  def self.binder_report_info
    {
        title: "Report to list all users",
        description: "This report helps us display all user info!!! fafa",
        params: [
          {name: :id, type: :text},
        ]
    }
  end

  def display_column?(name)
    name == 'email'
  end

  def sql
    User.all.to_sql
  end
end