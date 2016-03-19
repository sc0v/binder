class ListSccMembersReport < Dossier::Report

  def self.binder_report_info
    {
        title: "List all SCC Member",
        description: "This report lists the andrew ids of all SCC members."
    }
  end

  def format_header(column_name)
    return 'Andrew ID' if column_name == 'andrewid'
    column_name
  end

  def sql
    Participant.scc.select('andrewid').to_sql
  end
end