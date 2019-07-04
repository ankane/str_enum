require_relative "lib/str_enum/version"

Gem::Specification.new do |spec|
  spec.name          = "str_enum"
  spec.version       = StrEnum::VERSION
  spec.summary       = "String enums for Rails"
  spec.homepage      = "https://github.com/ankane/str_enum"
  spec.license       = "MIT"

  spec.author        = "Andrew Kane"
  spec.email         = "andrew@chartkick.com"

  spec.files         = Dir["*.{md,txt}", "{lib}/**/*"]
  spec.require_path  = "lib"

  spec.required_ruby_version = ">= 2.4"

  spec.add_dependency "activesupport", ">= 5"

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "minitest"
end
