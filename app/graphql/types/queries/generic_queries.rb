module Types
  module Queries
    module GenericQueries
      extend ActiveSupport::Concern

      included do
        ########################
        # Generic Queries
        ########################

        field :ping, String, "Ping", null: false
        def ping
          "Pong"
        end
      end
    end
  end
end
