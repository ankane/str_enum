# str_enum

Don’t like storing enums as integers in your database? Introducing...

String enums for Rails!! :tada:

- scopes
- validations
- accessor methods
- update methods

[![Build Status](https://github.com/ankane/str_enum/workflows/build/badge.svg?branch=master)](https://github.com/ankane/str_enum/actions)

## Getting Started

Add this line to your application’s Gemfile:

```ruby
gem "str_enum"
```

Add a string column to your model.

```ruby
add_column :users, :status, :string
```

And use:

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

And negative scopes

```ruby
User.not_active
User.not_archived
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

#### Update Methods

```ruby
user.active!
user.archived!
```

#### Forms

```erb
<%= f.select :status, User.statuses.map { |s| [s.titleize, s] } %>
```

## Options

Choose which features you want with:

```ruby
class User < ActiveRecord::Base
  str_enum :status, [:active, :archived],
    scopes: false,
    validate: false,
    accessor_methods: false,
    update_methods: false,
    default: nil
end
```

Prevent method name collisions with the `prefix` and `suffix` options.

```ruby
class User < ActiveRecord::Base
  str_enum :address_status, [:active, :archived], suffix: :address
end

# scopes
User.active_address
User.archived_address

# accessor methods
user.active_address?
user.archived_address?

# update methods
user.active_address!
user.archived_address!
```

## Migrating columns from Rails built-in `enum` to `str_enum`

If you are migrating legacy columns away from Rails built-in `enum`, but wish
to retain the same enum name, you may want to take a multi-step migration
process, especially if you have large tables.

One possible migration strategy involves specifying a column that differs from
your desired `str_enum` name.

For example, if you have an enum called `rank`

  1. Create a migration to add a new column for your `str_enum`, e.g.
     `rank_str`.
  2. Set up a double writing scheme to make sure all writes to the legacy
     enum are also written to the new `str_enum` column, for example via
     a callback:

      ```ruby
      before_validation :populate_str_enum_for_migration
      private def populate_str_enum_for_migration
        if rank_changed?
          self.rank_str = rank
        end
      end
      ```

  3. Create a data migration to copy all existing values from `rank` to
     `rank_str` as their string equivalents.
  4. Remove the legacy `enum` declaration and replace it with a `str_enum`
     declaration with an explicit `:column` property. Existing aliases and
     scopes should now refer to the those defined by `str_enum`. (**NOTE**: SQL
     statements that specify the column explicitly may need to be changed!)

      ```ruby
      class User < ActiveRecord::Base
        # DEPRECATED rank field that previously used the "rank
        # enum rank: [:lowly, :middling, :high_falutin]

        str_enum :rank, [:lowly, :middling, :high_falutin], column: :rank_str
      end
      ```

  5. Once you have validated that legacy column is no longer being written to,
     you may create a migration that deletes it, renames the new `str_enum`
     column to its name, then remove the `:column` specification from the
     `str_enum` above.

## History

View the [changelog](https://github.com/ankane/str_enum/blob/master/CHANGELOG.md)

## Contributing

Everyone is encouraged to help improve this project. Here are a few ways you can help:

- [Report bugs](https://github.com/ankane/str_enum/issues)
- Fix bugs and [submit pull requests](https://github.com/ankane/str_enum/pulls)
- Write, clarify, or fix documentation
- Suggest or add new features

To get started with development and testing:

```sh
git clone https://github.com/ankane/str_enum.git
cd str_enum
bundle install
bundle exec rake test
```
