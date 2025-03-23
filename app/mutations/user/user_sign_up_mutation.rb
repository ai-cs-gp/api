# frozen_string_literal: true

class UserSignUpMutation < BaseMutation
  required do
    string :first_name
    string :last_name
    string :email, matches: App::Constants::EMAIL_REGEX
    string :phone, matches: App::Constants::PHONE_REGEX
    string :password
  end

  def execute
    user = User.new(inputs)
    return handle_model(user) unless user.save

    # user.generate_email_otp!
    # begin
    #   ApplicationMailer.with(user: user, email: user.email).verify.deliver_now
    #   user.update!(email_otp_sent_at: Time.current)
    # rescue StandardError
    #   # user.errors.add(:email, e.message)
    # end

    user.populate_token
  end
end
