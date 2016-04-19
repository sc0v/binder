class ListLateShiftsReport < Dossier::Report
  # Don't forget to restart server to test changes to reports.
  # If the shift times are off in this report make sure that the timezones
  # on the mysql server are properly setup by running the following command in the shell:
  # mysql_tzinfo_to_sql /usr/share/zoneinfo | mysql -u root mysql

  def self.binder_report_info
    {
        title: "List late shifts",
        description: "Lists people who were late to a shift.
                      <strong>Choose to either show late shifts or missed.</strong>",
        params: [
            { name: :show_late_or_missed, type: :select,
              choices: [['Late', 'late'], ['Missed', 'missed']]}
        ]
    }
  end

  def sql
    if options[:show_late_or_missed] == 'late'
      ShiftParticipant.joins(:participant, shift: [:organization, :shift_type])
          .checked_in_late
          .select('organizations.name AS \'Organization\'',
                  'DATE_FORMAT(CONVERT_TZ (starts_at, \'UTC\', \'US/Eastern\'), \'%m/%d/%Y %h:%i %p\') AS \'Shift Start\'',
                  'DATE_FORMAT(CONVERT_TZ (clocked_in_at, \'UTC\', \'US/Eastern\') , \'%m/%d/%Y %h:%i %p\') AS \'Time Clocked In\'',
                  'TIMESTAMPDIFF(MINUTE, starts_at, clocked_in_at) AS \'Minutes Late\'',
                  'andrewid AS \'Andrew ID\'',
                  'shift_types.name AS \'Shift Type\'')
          .reorder('organizations.name, starts_at')
          .to_sql
    else
      Shift.joins(:organization, :shift_type)
          .past
          .missed
          .select('organizations.name AS \'Organization\'',
                  'DATE_FORMAT(CONVERT_TZ (starts_at, \'UTC\', \'US/Eastern\'), \'%m/%d/%Y %h:%i %p\') AS \'Shift Start\'',
                  '(required_number_of_participants - (
                      SELECT COUNT(*)
                      FROM shift_participants
                      WHERE shift_participants.shift_id = shifts.id)
                   ) AS \'Number of Slots Missed\'',
                  'shift_types.name AS \'Shift Type\'')
          .reorder('organizations.name, starts_at')
          .to_sql
    end
  end
end