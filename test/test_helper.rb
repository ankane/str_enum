require "bundler/setup"
Bundler.require(:default)
require "minitest/autorun"
require "minitest/pride"
require "active_record"

ActiveRecord::Base.logger = Logger.new(ENV["VERBOSE"] ? STDOUT : nil)
ActiveRecord::Migration.verbose = ENV["VERBOSE"]

# migrations
ActiveRecord::Base.establish_connection adapter: "sqlite3", database: ":memory:"

ActiveRecord::Migration.create_table :users do |t|
  t.string :status
  t.string :address_status
  t.string :kind
end

class User < ActiveRecord::Base
  str_enum :status, [:active, :archived]
  str_enum :address_status, [:active, :archived], prefix: :address
  str_enum :kind, [:guest, :vip], suffix: true
end
