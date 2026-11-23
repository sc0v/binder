# frozen_string_literal: true

require 'test_helper'

class ApplicationHelperTest < ActiveSupport::TestCase
  include ApplicationHelper

  test 'success flashes use the Web Kilt success tone' do
    assert_equal 'cmu-flash cmu-flash--success', flash_css_class('notice')
    assert_equal 'cmu-flash cmu-flash--success', flash_css_class(:success)
  end

  test 'error flashes use the Web Kilt error tone' do
    assert_equal 'cmu-flash cmu-flash--error', flash_css_class('alert')
    assert_equal 'cmu-flash cmu-flash--error', flash_css_class(:error)
  end

  test 'warning flashes use the Web Kilt notice tone' do
    assert_equal 'cmu-flash cmu-flash--notice', flash_css_class('warning')
  end

  test 'times of day are AP style' do
    day = Time.zone.local(2027, 4, 8)

    assert_equal '9 a.m.', ap_time(day.change(hour: 9))
    assert_equal '2:30 p.m.', ap_time(day.change(hour: 14, min: 30))
    assert_equal '12:15 a.m.', ap_time(day.change(hour: 0, min: 15))
  end

  test 'dates are AP style' do
    assert_equal 'Jan. 11', ap_date(Time.zone.local(2027, 1, 11))
    assert_equal 'Sept. 3', ap_date(Time.zone.local(2027, 9, 3))
    assert_equal 'March 5', ap_date(Time.zone.local(2027, 3, 5))
  end

  test 'time spans are AP style' do
    today = Time.zone.today.in_time_zone

    assert_equal '6-9 p.m.',
                 ap_time_range(today.change(hour: 18), today.change(hour: 21))
    assert_equal '11 a.m.-2 p.m.',
                 ap_time_range(today.change(hour: 11), today.change(hour: 14))
  end

  test 'a span on another day names the day' do
    tomorrow = Time.zone.tomorrow.in_time_zone
    day = tomorrow.strftime('%A')
    next_day = (tomorrow + 1.day).strftime('%A')

    assert_equal "#{day}, 6-9 p.m.",
                 ap_time_range(
                   tomorrow.change(hour: 18),
                   tomorrow.change(hour: 21)
                 )
    assert_equal "#{day}, 11 p.m.-#{next_day}, 2 a.m.",
                 ap_time_range(
                   tomorrow.change(hour: 23),
                   (tomorrow + 1.day).change(hour: 2)
                 )
  end

  test 'noon and midnight are words' do
    day = Time.zone.local(2027, 4, 8)

    assert_equal 'noon', ap_time(day.change(hour: 12))
    assert_equal 'midnight', ap_time(day)
  end
end
