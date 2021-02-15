require 'minitest/autorun'
require 'infrastructure'
require 'database_cleaner/sequel'

Database::Container.init

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
