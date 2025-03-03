module Twilio
  class Base


    def twilio_client
      account_sid = ENV['TWILIO_SID']
      auth_token = ENV['TWILIO_KEY']
      @client = Twilio::REST::Client.new(account_sid, auth_token)

    end
  end
end

