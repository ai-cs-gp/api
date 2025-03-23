module App
  class Jwt
    class << self
      def encode(payload)
        payload[:created_at] = Time.current.to_i
        JWT.encode(payload, Rails.application.credentials.secret_key_base)
      end

      def decode(token)
        body = JWT.decode(token, Rails.application.credentials.secret_key_base)[0]
        HashWithIndifferentAccess.new body
      rescue StandardError
        nil
      end
    end
  end
end
