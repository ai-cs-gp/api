module App
  class Sms
    class << self
      def send(number, message)
        # return if Rails.env.development?

        headers = {
          "Content-Type" => "application/json",
          "Accept" => "application/json",
          "Authorization" => "App #{ENV.fetch("INFOBIP_API_KEY", "change-me")}"
        }

        body = {
          messages: [
            {
              destinations: [{ to: number }],
              from: "16313189163",
              text: message
            }
          ]
        }

        res =
          Typhoeus.post(
            "https://dk1r51.api.infobip.com/sms/2/text/advanced",
            body: body.to_json,
            headers: headers
          )
        raise "Infobip error: #{res}" unless res.code.between?(200, 299)
        JSON.parse(res.body)
      end

      def otp(number, otp)
        send(number, "Your verification code is #{otp}")
      end
    end
  end
end
