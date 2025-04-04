require "bundler/setup"
Bundler.require(:default)
require "minitest/autorun"
require "minitest/pride"
require "active_record"

ActiveRecord.raise_on_assign_to_attr_readonly = true
ActiveRecord::Base.logger = Logger.new(ENV["VERBOSE"] ? STDOUT : nil)
ActiveRecord::Migration.verbose = ENV["VERBOSE"]

# migrations
ActiveRecord::Base.establish_connection adapter: "sqlite3", database: ":memory:"

ActiveRecord::Schema.define do
  create_table :users do |t|
    t.string :status
    t.string :address_status
    t.string :kind
    t.string :type
  end
end

class User < ActiveRecord::Base
  str_enum :status, [:active, :archived]
  str_enum :address_status, [:active, :archived], prefix: :address
  str_enum :kind, [:guest, :vip], suffix: true
  str_enum :type, [:permanent, :temporary], allow_nil: true, default: nil

  attr_readonly :type
end
