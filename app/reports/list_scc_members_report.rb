class ListSccMembersReport < Dossier::Report
  # Don't forget to restart server to test changes to reports.

  def self.binder_report_info
    {
        title: "List all SCC Member",
        description: "This report lists the AndrewIDs of all SCC members."
    }
  end

  def sql
    Participant.scc.select('andrewid AS \'Andrew ID\'',
                      'phone_number AS \'Phone Number\'')
              .to_sql
  end
end