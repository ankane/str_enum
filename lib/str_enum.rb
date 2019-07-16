# dependencies
require "active_support"

# modules
require "str_enum/model"
require "str_enum/version"

ActiveSupport.on_load(:active_record) do
  include StrEnum::Model
end
