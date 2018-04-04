class ListBoothChairsReport < Dossier::Report
  # Don't forget to restart server to test changes to reports.

  def self.binder_report_info
    {
        title: "List all booth chairs",
        description: "This report lists the AndrewID of all users that are
                      booth chairs and the organization they are a booth chair of."
    }
  end

  def sql
    Membership.joins(:organization, :participant).booth_chairs
              .select('organizations.name AS \'Organization\'', 'andrewid AS \'Andrew ID\'',
                      'phone_number AS \'Phone Number\'',
                      '(SELECT phone_carriers.name FROM phone_carriers WHERE phone_carriers.id = participants.phone_carrier_id) AS \'Phone Carrier\'')
              .order('organizations.name, andrewid').to_sql
  end
end