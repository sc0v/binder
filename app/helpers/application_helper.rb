# frozen_string_literal: true

module ApplicationHelper
  # Images
  #
  # Fallback image shown when a record-keyed asset (e.g. store/tool images
  # named after the record) is missing.
  PLACEHOLDER_IMAGE = 'placeholder.png'

  # Render an image_tag that falls back to PLACEHOLDER_IMAGE when the asset is
  # missing, instead of raising Propshaft::MissingAssetError and 500-ing the
  # whole page. Falls back to nothing if even the placeholder is absent.
  def safe_image_tag(source, options = {})
    image_tag(source, options)
  rescue Propshaft::MissingAssetError
    begin
      image_tag(PLACEHOLDER_IMAGE, options)
    rescue Propshaft::MissingAssetError
      nil
    end
  end

  # asset_path that falls back to the placeholder (then nil) instead of raising,
  # so it is safe to build data attributes (e.g. image_url) for the same source.
  def safe_asset_path(source)
    asset_path(source)
  rescue Propshaft::MissingAssetError
    begin
      asset_path(PLACEHOLDER_IMAGE)
    rescue Propshaft::MissingAssetError
      nil
    end
  end

  # Flash
  #
  # Map flash categories to css classes.
  def flash_css_class(name)
    tone =
      case name.to_s
      when 'notice', 'success'
        'success'
      when 'alert', 'error'
        'error'
      else
        'notice'
      end
    "cmu-flash cmu-flash--#{tone}"
  end

  # An error interrupts a screen reader (alert); anything else waits its
  # turn (status)
  def flash_role(name)
    %w[alert error].include?(name.to_s) ? 'alert' : 'status'
  end

  # A date in AP style: Jan. 11, Sept. 3, March 5 (no year)
  def ap_date(time)
    month = time.strftime('%B')
    month = month == 'September' ? 'Sept.' : "#{month[0, 3]}." if month.length >
      5
    "#{month} #{time.day}"
  end

  # The day, when it isn't today: the weekday within a week, else the date
  def ap_day(time)
    days = (time.to_date - Time.zone.today).to_i
    return if days.zero?

    days.between?(-6, 6) ? time.strftime('%A') : ap_date(time)
  end

  # A span of time in AP style: 6-9 p.m.; 11 a.m.-2 p.m.;
  # Thursday, 11 p.m.-Friday, 2 a.m.
  def ap_time_range(starts, ends)
    first = ap_time(starts)
    last = ap_time(ends)
    same_day = starts.to_date == ends.to_date
    meridiem = last[/ [ap]\.m\.\z/]
    first = first.delete_suffix(meridiem) if same_day && meridiem &&
      first.end_with?(meridiem)
    first = [ap_day(starts), first].compact.join(', ')
    last = [ap_day(ends), last].compact.join(', ') unless same_day
    "#{first}-#{last}"
  end

  # A time of day in AP style: 9 a.m., 2:30 p.m., noon, midnight
  def ap_time(time)
    return 'noon' if time.hour == 12 && time.min.zero?
    return 'midnight' if time.hour.zero? && time.min.zero?

    clock = time.min.zero? ? time.strftime('%-l') : time.strftime('%-l:%M')
    "#{clock} #{time.hour < 12 ? 'a.m.' : 'p.m.'}"
  end
end
