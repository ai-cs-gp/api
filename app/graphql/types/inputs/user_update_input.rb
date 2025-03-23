module Types
  module Inputs
    class UserUpdateInput < BaseInputObject
      description 'Attributes for updating user'

      argument :first_name, String, required: false
      argument :last_name, String, required: false
      argument :email, String, required: false
      argument :phone, String, required: false
      argument :password, String, required: false
    end
  end
end
