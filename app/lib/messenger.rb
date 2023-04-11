# frozen_string_literal: true

require 'net/http'

USER_UNSUBSCRIBED_FROM_TWILIO_ERROR_CODE = 21_610

module Messenger
  def send_sms(number, content)
=begin
    sid = ENV.fetch('TWILIO_ACCT_SID', nil)
    auth = ENV.fetch('TWILIO_AUTH', nil)

    @client = Twilio::REST::Client.new sid, auth

    from = '+14123854063'

    # The following try-rescue block is needed in case user unsubscribe
    # if the user ubsubscribe and we attempt to message them
    # the api will report an error

    begin
      message = @client.account.messages.create(
        from:,
        to: "+1#{number}",
        body: content
      )
    rescue Twilio::REST::RequestError => e
      case e.code
      when USER_UNSUBSCRIBED_FROM_TWILIO_ERROR_CODE
        Rails.logger.debug e.message
      end
    end
=end
  end

  def send_groupme(bot_id, text)
    # Send a message using the groupme bot API: https://dev.groupme.com/tutorials/bots
    return if Rails.env.test?

    uri = URI.parse('https://api.groupme.com/v3/bots/post')
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    req = Net::HTTP::Post.new(uri, 'Content-Type' => 'application/json')
    req.body = { bot_id:, text: }.to_json
    http.request(req)
  end

  def send_slack(webhook_url, text)
    # Send a message using the slack API: https://api.slack.com/methods/chat.postMessage
    slack_token = ENV.fetch('SLACK_BOT_TOKEN', nil)

    return unless !Rails.env.test? && !slack_token.nil?

    uri = URI.parse(webhook_url)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    req = Net::HTTP::Post.new(uri, 'Content-Type' => 'application/json')
    req.body = { text:, token: slack_token }.to_json
    http.request(req)
  end
end
