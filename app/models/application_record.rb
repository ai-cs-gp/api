class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  # `ransackable_attributes` by default returns all column names
  # and any defined ransackers as an array of strings.
  # For overriding with a whitelist array of strings.
  #
  def self.ransackable_attributes(auth_object = nil)
    column_names + _ransackers.keys
  end

  # `ransackable_associations` by default returns the names
  # of all associations as an array of strings.
  # For overriding with a whitelist array of strings.
  #
  def self.ransackable_associations(auth_object = nil)
    reflect_on_all_associations.map { |a| a.name.to_s }
  end

  # `ransortable_attributes` by default returns the names
  # of all attributes available for sorting as an array of strings.
  # For overriding with a whitelist array of strings.
  #
  def self.ransortable_attributes(auth_object = nil)
    ransackable_attributes(auth_object)
  end

  # `ransackable_scopes` by default returns an empty array
  # i.e. no class methods/scopes are authorized.
  # For overriding with a whitelist array of *symbols*.
  #
  def self.ransackable_scopes(auth_object = nil)
    []
  end

  # https://blog.rstankov.com/allowed-class-names-in-activerecord-polymorphic-associations/
  class << self
    def belongs_to_polymorphic(name, allowed_classes: [], **options)
      belongs_to name, polymorphic: true, **options

      validate "#{name}_allowed_classes_validator".to_sym

      define_method("#{name}_allowed_classes_validator") do
        return if allowed_classes.empty?
        return if send("#{name}").nil?

        unless allowed_classes
                 .map(&:name)
                 .compact
                 .include?(send("#{name}").class.name)
          errors.add(
            "#{name} Class",
            "must be one of #{allowed_classes.map(&:name).join(", ")}"
          )
        end
      end

      define_singleton_method("#{name}_types") { allowed_classes }

      # generates a generic finder method, TODO: fix for STI
      define_singleton_method("with_#{name}") do |type|
        type =
          case type
          when Class
            type.name
          when String
            type
          else
            type.class.name
          end
        where("#{name}_type" => type)
      end

      # generates scope for each allowed class
      allowed_classes.each do |model|
        scope "with_#{name}_#{model.name.underscore.tr("/", "_")}",
              -> { where("#{name}_type" => model.name) }
      end
    end
  end
end
