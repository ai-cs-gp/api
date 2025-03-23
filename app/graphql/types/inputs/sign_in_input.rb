module Types
  module Inputs
    class SignInInput < Types::BaseInputObject
      description "Attributes for signing in"

      argument :auth_method,
               Enums::AuthMethod,
               required: false,
               default_value: "email"
      argument :auth_value, String, required: true
      argument :password, String, required: true
    end
  end
end
