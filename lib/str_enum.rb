require "str_enum/version"
require "active_support"

module StrEnum
  def str_enum(column, values, validate: true, scopes: true, accessor_methods: true)
    values = values.map(&:to_s)
    validates column, presence: true, inclusion: {in: values} if validate
    values.each do |value|
      scope value, -> { where(column => value) } if scopes && !respond_to?(value)
      if accessor_methods && !method_defined?("#{value}?")
        define_method "#{value}?" do
          read_attribute(column) == value
        end
      end
    end
    after_initialize do
      send("#{column}=", values.first) unless send(column)
    end
  end
end

ActiveSupport.on_load(:active_record) do
  extend(StrEnum)
end
