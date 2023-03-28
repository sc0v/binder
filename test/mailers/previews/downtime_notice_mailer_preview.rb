# Preview all emails at http://localhost:3000/rails/mailers/downtime_notice_mailer
class DowntimeNoticeMailerPreview < ActionMailer::Preview
  def time_left_notice
    user = Participant.first
    DowntimeNoticeMailer.time_left_notice(user)
  end
end
