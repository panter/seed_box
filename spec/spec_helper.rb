require "bundler/setup"
require "seed_box"

ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  database: File.dirname(__FILE__) + '/test.sqlite3'
)

ActiveRecord::Schema.define version: 0 do
  create_table :seeded_users, force: true do |t|
    t.column :first_name, :string
    t.column :last_name, :string
  end
end

class SeededUser < ActiveRecord::Base
  validates :first_name, presence: true
end

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.before do
    SeededUser.delete_all
  end
end
