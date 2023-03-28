class DowntimeNoticeMailer < ApplicationMailer
  default from: 'sc0v@springcarnival.org'

  def time_left_notice(chair)
    @chair = chair
    mail(:to => @chair.email, :subject => "Organzation Downtime Ending Soon")
  end

end