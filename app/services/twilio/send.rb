module Twilio
  class Send < Base

    method_object :message_text

    def call
      data = send_sms
      if data
        {to: data.to, from: data.from, twilio_id: data.sid}
      end

    end


    private

    def send_sms
    @client = twilio_client
    begin
      @client.messages.create(
          # Need to use dummy numbers for testing purposes
          from: '+18667529020',
          to: '+18777804236',
          body: message_text
        )

      rescue Twilio::REST::TwilioError => e
        # Log Twilio-specific errors
        Rails.logger.error("Twilio SMS Error: #{e.message}")
        nil
      rescue StandardError => e
        # Catch and log any other unexpected errors
        Rails.logger.error("SMS Sending Error: #{e.message}")
        nil
      end
    end
  end
end