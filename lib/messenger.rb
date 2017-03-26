module Messenger

  def send_sms(number, content)
    sid = ENV["TWILIO_ACCT_SID"]
    auth = ENV["TWILIO_AUTH"]

    @client = Twilio::REST::Client.new sid, auth

    from = "+14123854063"

    message = @client.account.messages.create(
             :from => from,
             :to => '+1'+number,
             :body => content
    )
  end

  # def receive_sms
  #   body = params["Body"]
  #   puts "\n\n\nbody text right here boy: #{body}\n\n\n"
  #   Twilio::TwiML::Response.new do |r|
  #     if body == "renew"
  #       return 1
  #     elsif body == "cancel"
  #       return 0
  #     else
  #       return -1
  #     end
  #   end
  # end


end