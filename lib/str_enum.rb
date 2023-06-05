# dependencies
require "active_support"

# modules
require_relative "str_enum/model"
require_relative "str_enum/version"

ActiveSupport.on_load(:active_record) do
  include StrEnum::Model
end
