require "str_enum/version"
require "active_support"
require "str_enum/model"

ActiveSupport.on_load(:active_record) do
  include StrEnum::Model
end
