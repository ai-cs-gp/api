module WithCountry
  extend ActiveSupport::Concern

  class_methods do
    def countryable(countryable_field = :country_code, **options)
      { presence: false, uniqueness: false, allow_blank: true }.merge!(options)

      validates countryable_field,
                presence: options[:presence],
                uniqueness: options[:uniqueness],
                inclusion: {
                  in: App::Constants::SUPPORTED_COUNTRIES,
                  message: "is not supported",
                  allow_blank: options[:allow_blank]
                }

      before_validation lambda { self[countryable_field] = self[countryable_field]&.upcase }, if: "will_save_change_to_#{countryable_field}?".to_sym

      prefix_helper_method_name = countryable_field.to_s.delete_suffix("_code")

      define_method prefix_helper_method_name.to_sym do
        Country.new(code: self[countryable_field])
      end

      define_method "#{prefix_helper_method_name}=".to_sym do |country|
        if country.is_a?(Country)
          self[countryable_field] = country.code
        elsif country.is_a?(String)
          self[countryable_field] = country
        else
          raise ArgumentError, "Invalid country"
        end
      end
    end
  end
end
