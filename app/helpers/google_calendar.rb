require_relative 'google_calendar_helper'

# Initialize the API via our helper
@calendar_helper = GoogleCalendarHelper.new
@calendar = @calendar_helper.calendar

# List all calendars that the service account has access to
page_token = nil
begin
  result = @calendar.list_calendar_lists(page_token: page_token)
  if result.items.empty?
  puts "No access to any calendar!"
  else
  result.items.each do |c|
    puts "CAL: #{c.summary}"
  end
  if result.next_page_token != page_token
    page_token = result.next_page_token
  else
    page_token = nil
  end
  end
end while !page_token.nil?

# Create a new hour-long event that takes place an hour from now
# MINUTES_PER_DAY = 60 * 24
# date_start = DateTime.now + Rational(60, MINUTES_PER_DAY)
# date_end = date_start + Rational(60, MINUTES_PER_DAY)

# event = Google::Apis::CalendarV3::Event.new({
#   summary: 'Calendar API Test Event',
#   location: 'Test',
#   description: 'Testing the Calendar API',
#   start: {
#     date_time: date_start
#   },
#   end: {
#     date_time: date_end
#   },
#   attendees: [
#     {email: 'some_attendee@gmail.com'},
#     {email: 'some_student@university.edu'}
#   ]
# })

# result = @calendar.insert_event(GoogleCalendarHelper::CALENDAR_ID, event)
# puts "Event created: #{result.to_yaml}"


response = @calendar.list_events(GoogleCalendarHelper::CALENDAR_ID,
                              max_results: 10,
                              single_events: true,
                              order_by: 'startTime',
                              time_min: Time.now.iso8601)

puts "Upcoming events:"
puts "No upcoming events found" if response.items.empty?
response.items.each do |event|
  start = event.start.date || event.start.date_time
  puts "- #{event.summary} (#{start})"
  puts event.to_yaml
end



