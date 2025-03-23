module Types
  module Inputs
    class SignUpInput < BaseInputObject
      description 'Attributes for signing up'

      argument :first_name, String, required: true
      argument :last_name, String, required: true
      argument :email, String, required: true
      argument :phone, String, required: true
      argument :password, String, required: true
    end
  end
end
