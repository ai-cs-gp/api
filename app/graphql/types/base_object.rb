# frozen_string_literal: true

module Types
  class BaseObject < GraphQL::Schema::Object
    edge_type_class(Types::BaseEdge)
    connection_type_class(Types::BaseConnection)
    field_class(Types::BaseField)

    # Generate a page type for this object,
    # or use an already-cached one.
    def self.page_type
      @page_type ||= BasePage.create(self)
    end

    # handle Mutations gem outcome
    def handle(outcome)
      unless outcome.success?
        # Rollbar.error(outcome.errors)
        return GraphQL::ExecutionError.new(outcome.errors.message&.first[1], options: outcome.errors.message)
      end

      outcome.result
    rescue StandardError => e
      # Rollbar.error(e)
      GraphQL::ExecutionError.new('Operation failed', options: e.message)
    end
  end
end
