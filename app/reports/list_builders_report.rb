class ListBuildersReport < Dossier::Report
  # Don't forget to restart server to test changes to reports.

  def self.binder_report_info
    {
        title: "List all participants that are builders",
        description: "List all participants that are builders. This includes anyone belonging to a
                      Fraternity, Sorority, Independent, Blitz, or Concessions organization."
    }
  end

  def sql
    Organization.joins(:participants).only_categories(%w[Fraternity Sorority Independent Blitz Concessions])
        .select('REPLACE( participants.cached_name, participants.cached_surname, "") AS \'First Name\'','participants.cached_surname AS \'Last Name\'','organizations.name AS \'Organization\'', 'andrewid AS \'Andrew ID\'',
                'phone_number AS \'Phone Number\'',
                '(SELECT phone_carriers.name FROM phone_carriers WHERE phone_carriers.id = participants.phone_carrier_id) AS \'Phone Carrier\'')
        .reorder('organizations.name').to_sql
  end

end