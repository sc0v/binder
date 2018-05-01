require 'googleauth'
require 'google/apis/calendar_v3'

  
class GoogleCalendarHelper
  attr_reader :calendar
  SCOPE = ["https://www.googleapis.com/auth/calendar"]
  CALENDAR_ID = 'sccakim1@gmail.com'
  
  def initialize
    @calendar = Google::Apis::CalendarV3::CalendarService.new
    # get_application_default forces the use of this environment variable.
    # Set it to the location of your JSON credentials.
    ENV["GOOGLE_APPLICATION_CREDENTIALS"] = "lib/keyfile.json"
    @calendar.authorization = Google::Auth.get_application_default(SCOPE)
  end
end
  
