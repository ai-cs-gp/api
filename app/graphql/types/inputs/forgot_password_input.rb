module Types
  module Inputs
    class ForgotPasswordInput < BaseInputObject
      description 'Attributes for forgetting password'

      argument :auth_method, Enums::AuthMethod, required: true
      argument :auth_value, String, required: true
    end
  end
end
