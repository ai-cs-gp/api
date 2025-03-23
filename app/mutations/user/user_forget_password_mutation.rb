class ForgetPasswordMutation < Mutations::Command
  required do
    string :auth_method, in: %w[email phone]
    string :auth_value
  end

  def execute
    is_email = inputs[:auth_method].downcase == 'email'
    inputs[:auth_value] = inputs[:auth_value].downcase if is_email
    inputs[:auth_value] = Phonelib.parse(inputs[:auth_value]).full_e164 unless is_email

    user = User.find_by(inputs[:auth_method] => inputs[:auth_value])
    return add_error(inputs[:auth_method].to_sym, :not_found, 'User not found') if user.nil?

    if user.reset_password_otp_sent_at && user.reset_password_otp_sent_at > App::Constants::RESET_PASSWORD_OTP_COOLDOWN.ago
      return add_error(inputs[:auth_method].to_sym, :cooldown, 'OTP cooldown')
    end

    user.generate_reset_password_otp!

    begin
      ApplicationMailer.reset_password_otp(user).deliver_now
    rescue StandardError => e
      user.errors.add(:email, e.message)
    end

    user.update(reset_password_otp_sent_at: Time.current)

    true
  end
end
