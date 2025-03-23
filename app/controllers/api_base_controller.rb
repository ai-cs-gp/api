class ApiBaseController < ActionController::API
  # around_action :switch_locale

  # GET /health_check
  def health_check
    render json: { status: "ok" }
  end

  private

  def decoded_token
    # if Rails.env.development?
    #   # CLIENT TOKEN
    #   # token = 'eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoiY2xpZW50QHRhd3JlZWQuY29tIiwiY3JlYXRlZF9hdCI6MTczMDM4MTYzOX0.pI43z4eW4yp9JH1XWTCwhEB3F5CDMFzaUyxid6mRHrI'
    #   # VENDOR TOKEN
    #   token = 'eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoidmVuZG9yQHRhd3JlZWQuY29tIiwiY3JlYXRlZF9hdCI6MTczMDIyMzgyMX0.oiICzvYFA93Czwg4Sxud_mqoXgbBH8ZVLDK0q9lkoS0'
    #   return @decoded_token = App::Jwt.decode(token)
    # end

    return @decoded_token if @decoded_token.present?
    return nil if request.headers["Authorization"].blank?
    token = request.headers["Authorization"].split(" ").last
    @decoded_token = App::Jwt.decode(token)
  rescue StandardError
    nil
  end

  def current_user
    return @current_user if @current_user.present?
    return nil if decoded_token.blank?
    if (Time.at(decoded_token[:created_at]) + 6.months) < Time.current
      return nil
    end
    # Use email in development and id in production
    user =
      User.find_by(
        Rails.env == "development" ? :email : :id => decoded_token[:user_id]
      )
    # device = user.devices[decoded_token[:device_uid]]
    # return nil if device.nil?
    @current_user = user
  rescue StandardError
    nil
  end

  def current_device_uid
    return @current_device_uid if @current_device_uid.present?
    return nil if decoded_token.blank?
    @current_device_uid = decoded_token[:device_uid]
  rescue StandardError
    nil
  end

  def current_client_device
    {
      uid:
        request.headers["Client-Device-UID"] || "Unknown-#{SecureRandom.uuid}",
      brand: request.headers["Client-Device-Brand"],
      type: request.headers["Client-Device-Type"],
      manufacturer: request.headers["Client-Device-Manufacturer"],
      model_name: request.headers["Client-Device-Model-Name"],
      os_name: request.headers["Client-Device-OS-Name"],
      os_version: request.headers["Client-Device-OS-Version"]
    }
  end

  def current_country
    # supported_iso_codes = ['EG', 'SA', 'AE', 'OM', 'BH', 'IQ']
    # iso_code = request.headers["Cf-Ipcountry"].try(:upcase) || 'EG'
    # iso_code = 'EG' unless supported_iso_codes.include?(iso_code)
    # iso_code
    request.headers["Cf-Ipcountry"].try(:upcase) ||
      App::Constants::DEFAULT_COUNTRY
  end

  def current_ip
    return request.remote_ip if Rails.env.development?
    request.headers["Cf-Connecting-Ip"] ||
      request.headers["X-Forwarded-For"].split(",").first
  end

  def current_locale
    locale = request.headers["Current-Locale"] || App::Constants::DEFAULT_LOCALE
    return locale if I18n.available_locales.include?(locale.to_sym)
    App::Constants::DEFAULT_LOCALE_FOR_LANGS[locale.first(2)] ||
      App::Constants::DEFAULT_LOCALE
  end

  def current_locale_country
    current_locale.last(2)
  end

  def current_locale_lang
    current_locale.first(2)
  end

  def update_user_current_locale
    return unless current_user.present?
    if current_user.locale != current_locale
      current_user.update(locale: current_locale)
    end
  end

  def switch_locale(&action)
    I18n.with_locale(current_locale, &action)
  end
end
