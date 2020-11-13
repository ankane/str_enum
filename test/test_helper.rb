require "bundler/setup"
Bundler.require(:default)
require "minitest/autorun"
require "minitest/pride"
require "active_record"

Minitest::Test = Minitest::Unit::TestCase unless defined?(Minitest::Test)

# for debugging
ActiveRecord::Base.logger = Logger.new(STDOUT) if ENV["DEBUG"]

# migrations
ActiveRecord::Base.establish_connection adapter: "sqlite3", database: ":memory:"

ActiveRecord::Migration.create_table :users do |t|
  t.string :status
  t.string :address_status
  t.string :kind
  t.string :rank_str
end

class User < ActiveRecord::Base
  str_enum :status, [:active, :archived]
  str_enum :address_status, [:active, :archived], prefix: :address
  str_enum :kind, [:guest, :vip], suffix: true
  str_enum :rank, [:lowly, :middling, :high_falutin], column: :rank_str
end
