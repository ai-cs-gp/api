module WithTranslation
  extend ActiveSupport::Concern

  included do
    class_attribute :translatables, default: []
    class_attribute :translatable_attributes, default: []
  end

  class_methods do
    def translatable(*new_translatables, **options)
      self.translatables += new_translatables
      self.translatable_attributes +=
        translatables.flat_map { |translatable| I18n.underscore_available_locales.map { |locale| "#{translatable}_#{locale}".to_sym } }

      extend Mobility
      translates(*new_translatables, **options)

      auto_strip_attributes(*translatable_attributes, squish: true, virtual: true)
    end
  end
end
