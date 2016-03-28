class ListBoothChairsReport < Dossier::Report

  def self.binder_report_info
    {
        title: "List all booth chairs",
        description: "This report lists the andrew id of all users that are
                      booth chairs and the organization they are a booth chair of."
    }
  end

  def format_header(column_name)
    return 'Organization' if column_name == 'name'
    return 'Andrew ID' if column_name == 'andrewid'
    column_name
  end

  def sql
    Membership.joins(:participant, :organization).booth_chairs.select('name', 'andrewid')
              .order('organizations.name, andrewid').to_sql
  end
end