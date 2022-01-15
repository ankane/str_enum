require "active_support/concern"

module StrEnum
  module Model
    extend ActiveSupport::Concern

    class_methods do
      def str_enum(enum_name, values, validate: true, scopes: true, accessor_methods: true, update_methods: true, prefix: false, suffix: false, default: true, allow_nil: false, column: enum_name)
        values = values.map(&:to_s)
        if validate
          validate_options = {}
          if allow_nil
            validate_options[:allow_nil] = true
          else
            validate_options[:presence] = true
          end
          validate_options[:inclusion] = {in: values}
          validates column, validate_options
        end
        values.each do |value|
          prefix = enum_name if prefix == true
          suffix = enum_name if suffix == true
          method_name = [prefix, value, suffix].select { |v| v }.join("_")
          if scopes
            scope method_name, -> { where(column => value) } unless respond_to?(method_name)
            scope "not_#{method_name}", -> { where.not(column => value) } unless respond_to?("not_#{method_name}")
          end
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
        define_singleton_method enum_name.to_s.pluralize do
          values
        end
        if enum_name.to_s != column.to_s
          # the enum_name is then an alias to the column
          define_method(enum_name) do
            read_attribute(column)
          end

          define_method("#{enum_name}=") do |value|
            send("#{column}=", value)
          end
        end
      end
    end
  end
end
