module WithPhone
  extend ActiveSupport::Concern

  class_methods do
    def phonable(phonable_field = :phone, **options)
      { presence: false, uniqueness: false, allow_blank: false }.merge!(options)

      before_validation lambda { self[phonable_field] = Phonelib.parse(self[phonable_field]).full_e164 }, if: "will_save_change_to_#{phonable_field}?".to_sym

      validates phonable_field,
                presence: options[:presence],
                uniqueness: options[:uniqueness],
                allow_blank: options[:allow_blank],
                phone: {
                  possible: true,
                  allow_blank: true,
                  types: [:mobile],
                  countries: App::Constants::SUPPORTED_COUNTRIES.map { |c| c.downcase.to_sym }
                  # country_specifier: ->(instance) { instance.country.iso_code }
                }.merge(options.except(:presence, :uniqueness)),
                if: "will_save_change_to_#{phonable_field}?".to_sym
    end
  end
end
