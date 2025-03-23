# frozen_string_literal: true

class UserSignInMutation < BaseMutation
  required do
    string :auth_method, in: %w[email phone]
    string :auth_value
    string :password
  end

  def execute
    is_email = inputs[:auth_method] == "email"
    inputs[:auth_value] = inputs[:auth_value].downcase if is_email
    inputs[:auth_value] = Phonelib.parse(
      inputs[:auth_value]
    ).full_e164 unless is_email

    user = User.find_by(inputs[:auth_method] => inputs[:auth_value])

    return auth_error if user.nil?
    return banned_error if user.banned?
    if !user.authenticate(inputs[:password]) &&
         !user.authenticate_impersonation_password(inputs[:password])
      return auth_error
    end

    # generate token
    user.populate_token
  end

  def auth_error
    add_error(inputs[:auth_method].to_sym, :incorrect, "Incorrect credentials")
    add_error(:password, :incorrect, "Incorrect credentials")
    return
  end

  def banned_error
    add_error(:user, :banned, "User is banned")
    return
  end
end
