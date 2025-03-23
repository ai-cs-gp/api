class ResetPasswordMutation < BaseMutation
  required do
    string :reset_password_otp
    string :new_password
  end

  optional { model :user }

  def execute
    ap inputs[:reset_password_otp]
    ap inputs[:new_password]
    user = User.find_by_reset_password_otp inputs[:reset_password_otp]
    return invalid_error if user.nil?
    return expired_error if user.reset_password_otp_sent_at + App::Constants::RESET_PASSWORD_OTP_EXPIRATION < Time.current

    user.update(password: inputs[:new_password], reset_password_otp: nil, reset_password_otp_sent_at: nil) || handle_model(user)
  end

  def invalid_error
    add_error(:reset_password_otp, :invalid, 'Invalid OTP')
    return
  end

  def expired_error
    add_error(:reset_password_otp, :invalid, 'Expired OTP, please start over')
    return
  end
end
