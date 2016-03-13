class ListAllUsersReport < Dossier::Report

  # Don't forget to restart server to test changes.
  def self.binder_report_info
    {
        title: "Report to list all users",
        description: "This report helps us display all user info",
        params: [
          {name: :id, type: :text},
          {name: :organization, type: :association, choices: Organization.all}
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