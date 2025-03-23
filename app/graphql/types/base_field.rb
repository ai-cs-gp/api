# frozen_string_literal: true

module Types
  class BaseField < GraphQL::Schema::Field
    argument_class Types::BaseArgument

    def initialize(*args, authorize: nil, cache: nil, **kwargs, &block)
      super(*args, **kwargs, &block)

      extension(FieldExtensions::AuthorizationExtension, authorize) if authorize.present?

      if cache.is_a?(Hash)
        extension(FieldExtensions::CacheExtension, **cache)
      elsif cache
        extension(FieldExtensions::CacheExtension)
      end

      return_type = kwargs[:type]
      extension(FieldExtensions::PageWrapperExtension) if return_type.is_a?(Class) && return_type < Types::BasePage
    end
  end
end
