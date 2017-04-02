module Messenger

  def send_sms(number, content)
    sid = ENV["TWILIO_ACCT_SID"]
    auth = ENV["TWILIO_AUTH"]

    @client = Twilio::REST::Client.new sid, auth

    from = "+14123854063 "

    message = @client.account.messages.create(
             :from => from,
             :to => '+1'+number,
             :body => content
    )
  end

  def receive_sms

  end

end