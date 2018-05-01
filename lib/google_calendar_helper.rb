require 'googleauth'
require 'google/apis/calendar_v3'

# This code was used from http://cirefice.me/software%20development/integrating-rails-with-google-apis 
# Credit goes to Christopher S. Cirefice

class GoogleCalendarHelper
  attr_reader :calendar
  SCOPE = ["https://www.googleapis.com/auth/calendar"]
  # this calendar ID should correspond with the ID of the calendar you want to 
  # pull events from, check step 7 in docs/googleCalendarTutorial.pdf to learn
  # how to find the ID of your google calendar
  CALENDAR_ID = 'sccakim1@gmail.com'
  
  def initialize
    @calendar = Google::Apis::CalendarV3::CalendarService.new

    # get_application_default forces the use of this environment variable.
    # Set it to the location of your JSON credentials.
    ENV["GOOGLE_APPLICATION_CREDENTIALS"] = "lib/keyfile.json"
    @calendar.authorization = Google::Auth.get_application_default(SCOPE)
  end
end
  
