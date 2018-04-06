require 'net/http'

USER_UNSUBSCRIBED_FROM_TWILIO_ERROR_CODE = 21610

module Messenger

  def send_sms(number, content)
    sid = ENV["TWILIO_ACCT_SID"]
    auth = ENV["TWILIO_AUTH"]

    @client = Twilio::REST::Client.new sid, auth

    from = "+14123854063"

    # The following try-rescue block is needed in case user unsubscribe
    # if the user ubsubscribe and we attempt to message them
    # the api will report an error

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

  def send_groupme(bot_id, text)
    # Send a message using the groupme bot API: https://dev.groupme.com/tutorials/bots
    if !Rails.env.test?
      uri = URI.parse('https://api.groupme.com/v3/bots/post')
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      req = Net::HTTP::Post.new(uri, 'Content-Type' => 'application/json')
      req.body = {bot_id: bot_id, text: text}.to_json
      http.request(req)
    end
  end

end
