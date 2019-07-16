require "active_support/concern"

module StrEnum
  module Model
    extend ActiveSupport::Concern

    class_methods do
      def str_enum(column, values, validate: true, scopes: true, accessor_methods: true, update_methods: true, prefix: false, suffix: false, default: true, allow_nil: false)
        values = values.map(&:to_s)
        if validate
          validate_options = {inclusion: {in: values}}
          if allow_nil
            validate_options[:allow_nil] = true
          else
            validate_options[:presence] = true
          end
          validates column, validate_options
        end
        values.each do |value|
          prefix = column if prefix == true
          suffix = column if suffix == true
          method_name = [prefix, value, suffix].select { |v| v }.join("_")
          scope method_name, -> { where(column => value) } if scopes && !respond_to?(method_name)
          if accessor_methods && !method_defined?("#{method_name}?")
            define_method "#{method_name}?" do
              read_attribute(column) == value
            end
          end
          if update_methods && !method_defined?("#{method_name}!")
            define_method "#{method_name}!" do
              update!(column => value)
            end
          end
        end
        default_value = default == true ? values.first : default
        after_initialize do
          send("#{column}=", default_value) unless try(column)
        end
        define_singleton_method column.to_s.pluralize do
          values
        end
      end
    end
  end
end
