require 'twilio-ruby'

class S_M_S

  def self.send(phone_number,message)
    account_sid = '[Error]'
    auth_token = '[Error]'
    from = '+14124447722'
    client = Twilio::REST::Client.new account_sid, auth_token

    client.account.messages.create({
      :from => from,
      :to => phone_number,
      :body => message
      })
      
  end 
end
