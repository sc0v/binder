USER_UNSUBSCRIBED_FROM_TWILIO_ERROR_CODE = 21610

module Messenger

  def send_sms(number, content)
    sid = ENV["TWILIO_ACCT_SID"]
    auth = ENV["TWILIO_AUTH"]

    @client = Twilio::REST::Client.new sid, auth

    from = "+14123854063 "

    begin
      message = @client.account.messages.create(
          :from => from,
          :to => '+1'+number,
          :body => content
      )
    rescue Twilio::REST::RequestError => e
      case e.code
        when USER_UNSUBSCRIBED_FROM_TWILIO_ERROR_CODE
          puts e.message
      end
    end
  end

end