# str_enum

Don’t want to store enums as integers in your database? Introducing...

String enums for Rails!! :tada:

- scopes
- validations
- accessor methods

## Getting Started

Add this line to your application’s Gemfile:

```ruby
gem 'str_enum'
```

In your models, use:

```ruby
class User < ActiveRecord::Base
  str_enum :status, [:active, :archived]
end
```

The first value will be the initial value. This gives you...

### Scopes

```ruby
User.active
User.archived
```

### Validations

```ruby
user = User.new(status: "unknown")
user.valid? # false
```

### Accessor Methods

```ruby
user.active?
user.archived?
```

## Customize

Choose which features you want

```ruby
class User < ActiveRecord::Base
  str_enum :status, [:active, :archived], scopes: false, validate: false, accessor_methods: false
end
```

## Contributing

Everyone is encouraged to help improve this project. Here are a few ways you can help:

- [Report bugs](https://github.com/ankane/str_enum/issues)
- Fix bugs and [submit pull requests](https://github.com/ankane/str_enum/pulls)
- Write, clarify, or fix documentation
- Suggest or add new features
