require "test_helper"

class DowntimeNoticeMailerTest < ActionMailer::TestCase
  def setup
    @participant = participants(:one)
  end

  test 'welcome' do
    email = DowntimeNoticeMailer.time_left_notice(@participant)
    assert_emails 1 do
      email.deliver_later
    end

    assert_equal email.to, [@participant.email]
    assert_equal email.from, ['ux@springcarnival.org']
    assert_equal email.subject, 'Organzation Downtime Ending Soon'
  end
end
