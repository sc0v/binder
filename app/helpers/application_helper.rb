module ApplicationHelper
#standard date for the app
def time(d)
  d.strftime("%I:%M%p")
end

def date(d)
  d.strftime("%m/%d/%y")
end

def date_and_time(d)
  [date(d), time(d)].compact.join(" ")
end

end
