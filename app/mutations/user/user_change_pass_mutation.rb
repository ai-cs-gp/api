# frozen_string_literal: true

class ChangePassMutation < BaseMutation
  required do
    model :user
    string :password
    string :new_password, min_length: 5
  end

  def execute
    user = inputs[:user]
    return auth_error unless user.authenticate(password)

    user.update(password: new_password)

    handle_model user
  end

  def auth_error
    add_error(:password, :incorrect, "Incorrect password.")
    return
  end
end
