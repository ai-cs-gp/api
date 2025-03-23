module App
  class Constants
    PROTOCOL = "https://"
    DOMAIN = "gp-admin.com"
    URL = "#{PROTOCOL}#{DOMAIN}"

    S3_ENDPOINT = "https://nbg1.your-objectstorage.com"
    S3_BUCKET_ENDPOINT = "https://gp-admin.nbg1.your-objectstorage.com"

    RESET_PASSWORD_OTP_COOLDOWN = 1.minute
    RESET_PASSWORD_OTP_EXPIRATION = 10.minutes

    MAX_CATEGORIES_PER_REQUEST = 2

    MAX_ATTACHMENTS_PER_REQUEST_ITEM = 3
    MAX_ATTACHMENTS_PER_OFFER_ITEM = 3

    REQUEST_ACTIVE_DURATION = 7.days

    EMAIL_REGEX = /\A\b[A-Z0-9\.\_\%\-\+]+@(?:[A-Z0-9\-]+\.)+[A-Z]{2,6}\b\z/i
    PHONE_REGEX = /\A[0-9\-\+]{10,15}\z/
    PASSWORD_REGEX = /\A(?=.*[a-zA-Z])(?=.*[0-9]).{6,}\z/

    SUPPORTED_LANGS = %w[en ar].freeze
    SUPPORTED_COUNTRIES = %w[EG].freeze
    DEFAULT_COUNTRY = "EG".freeze
    DEFAULT_LOCALE = "en-EG".freeze
    DEFAULT_LOCALE_FOR_LANGS = { "en" => "en-EG", "ar" => "ar-EG" }.freeze

    INVITATION_EXPIRATION_TIME = 7.days

    DEFAULT_PAGE_SIZE = 20
    MAX_PAGE_SIZE = 100
  end
end
