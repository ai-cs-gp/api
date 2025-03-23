module Types
  module Enums
    class AuthMethod < Types::BaseEnum
      value 'EMAIL', 'Email', value: 'email'
      value 'PHONE', 'Phone', value: 'phone'
    end
  end
end
