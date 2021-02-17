ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'
require 'minitest/autorun'

module ActiveSupport
  class TestCase
    # Run tests in parallel with specified workers
    parallelize(workers: 1)
  end
end

if Database::Container.with_database?
  DatabaseCleaner[:sequel].strategy = :transaction
  DatabaseCleaner[:sequel, db: Database::Config.config.default_gateway]

  module DatabaseCleanerSupport
    def before_setup
      super
      DatabaseCleaner[:sequel].start
    end

    def before_teardown
      DatabaseCleaner[:sequel].clean
      super
    end
  end

  module Minitest
    class Test
      include DatabaseCleanerSupport
    end
  end
end

