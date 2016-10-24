# str_enum

Don’t like storing enums as integers in your database? Introducing...

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

The first value will be the initial value. This gives you:

#### Scopes

```ruby
User.active
User.archived
```

#### Validations

```ruby
user = User.new(status: "unknown")
user.valid? # false
```

#### Accessor Methods

```ruby
user.active?
user.archived?
```

## Options

Choose which features you want with:

```ruby
class User < ActiveRecord::Base
  str_enum :status, [:active, :archived], scopes: false, validate: false, accessor_methods: false
end
```

Prevent name collisions with the `prefix` option.

```ruby
class User < ActiveRecord::Base
  str_enum :address_status, [:active, :archived], prefix: :address
end

# scopes
User.address_active
User.address_archived

# accessor methods
user.address_active?
user.address_archived?
```

## History

View the [changelog](https://github.com/ankane/str_enum/blob/master/CHANGELOG.md)

## Contributing

Everyone is encouraged to help improve this project. Here are a few ways you can help:

- [Report bugs](https://github.com/ankane/str_enum/issues)
- Fix bugs and [submit pull requests](https://github.com/ankane/str_enum/pulls)
- Write, clarify, or fix documentation
- Suggest or add new features
