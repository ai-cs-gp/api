module Types
  module Inputs
    class ResetPasswordInput < BaseInputObject
      description 'Attributes for resetting password'

      argument :reset_password_otp, String, required: true
      argument :new_password, String, required: true
    end
  end
end
