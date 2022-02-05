# frozen_string_literal: true

require 'bundler/setup'
require 'rails/railtie'
require 'active_record'
require 'sqlite3'
require 'helium/console/rails'
require 'helium/console/rspec'
require 'temping'
require 'byebug'

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

ActiveRecord::Base.establish_connection(
  adapter: :sqlite3,
  database: ':memory:'
)
