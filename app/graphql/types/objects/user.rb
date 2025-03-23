# frozen_string_literal: true

module Types
  module Objects
    class User < Types::BaseObject
      field :id, ID, null: false
      field :email, String, null: false
      field :phone, String, null: false
      field :first_name, String, null: false
      field :last_name, String, null: false
      field :gender, String
      field :locale, String
      field :dob, GraphQL::Types::ISO8601DateTime
      field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    end
  end
end
