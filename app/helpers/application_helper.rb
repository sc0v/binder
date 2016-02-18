module ApplicationHelper

  def display_base_errors resource
    return '' if (resource.errors.empty?) or (resource.errors[:base].empty?)
    messages = resource.errors[:base].map { |msg| content_tag(:p, msg) }.join
    html = <<-HTML
    <div class="alert alert-error alert-block">
    <button type="button" class="close" data-dismiss="alert">&#215;</button>
    #{messages}
    </div>
    HTML
    html.html_safe
  end

  def time(display_time)
    time_zone = ActiveSupport::TimeZone.new("Eastern Time (US & Canada)")
    display_time.in_time_zone(time_zone).strftime("%I:%M%p")
  end

  def date(display_date)
    time_zone = ActiveSupport::TimeZone.new("Eastern Time (US & Canada)")
    display_date.in_time_zone(time_zone).strftime("%m/%d/%y")
  end

  def date_and_time(display_date_and_time)
    [date(display_date_and_time), time(display_date_and_time)].compact.join(" ")
  end

  def format_boolean(bool)
    bool ? "Yes" : "No"
  end

  def currency(display_currency)
    number_to_currency(display_currency)
  end

  def format_downtime(downtime)
    downtime = downtime.to_i
    hours = downtime / 3600
    minutes = (downtime % 3600) / 60
    return ("%d" % hours) + ":" + ("%02d" % minutes)
  end

  def format_remaining_downtime(downtime)
    downtime = downtime.to_i
    if downtime < 0
      neg = '-'
      downtime *= -1
    else
      neg = ''
    end

    hours = downtime / 3600
    minutes = ((downtime % 3600) + 59) / 60
    return neg + ("%d" % hours) + ":" + ("%02d" % minutes)
  end

  def param_equals_i(param, value)
    return false if params[param].nil?
    params[param].to_i == value
  end

  def param_equals_s(param, value)
    return false if params[param].nil?
    params[param].strip == value
  end
end
