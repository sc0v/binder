class ListSccMembersReport < Dossier::Report
  # Don't forget to restart server to test changes to reports.

  def self.binder_report_info
    {
        title: "List all SCC Member",
        description: "This report lists the andrew ids of all SCC members."
    }
  end

  def sql
    Participant.scc.select('andrewid AS \'Andrew ID\'',
                      'phone_number AS \'Phone Number\'',
                      '(SELECT phone_carriers.name FROM phone_carriers WHERE phone_carriers.id = participants.phone_carrier_id) AS \'Phone Carrier\'')
              .to_sql
  end
end