# frozen_string_literal: true

class UserUpdateMutation < BaseMutation
  required { model :user }

  optional do
    string :first_name
    string :last_name
    string :email
    string :phone
    string :password
  end

  def execute
    attributes = inputs.except(:user).compact_blank
    user.assign_attributes(attributes)
    return handle_model(user) unless user.save

    # if user.email_changed?
    #   user.generate_email_otp!

    #   begin
    #     ApplicationMailer.with(user: user, email: user.email).verify.deliver_now
    #     user.update!(email_otp_sent_at: Time.current)
    #   rescue StandardError
    #     # user.errors.add(:email, e.message)
    #   end
    # end

    user
  end
end
