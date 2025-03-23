# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    include Types::Mutations::AuthMutations
  end
end
