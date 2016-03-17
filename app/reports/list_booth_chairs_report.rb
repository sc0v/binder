class ListBoothChairsReport < Dossier::Report

  def self.binder_report_info
    {
        title: "List all booth chairs",
        description: "This report lists all users that are booth chairs."
    }
  end

  def format_header(column_name)
    return 'Organization' if column_name == 'name'
    return 'Andrew ID' if column_name == 'andrewid'
    column_name
  end

  def sql
    Membership.joins(:participant, :organization).booth_chairs.select('andrewid', 'name').order('andrewid').to_sql
  end
end