require 'rom-sql'

module Biblio
  module Db
    module Config
      OPTS = {
        username: 'postgres',
        password: 'root',
        encoding: 'UTF8',
        scheme: 'postgres',
        server_version: '12.0',
        migrator: { path: 'lib/biblio/db/migrate' }
      }.freeze

      def init_rom!
        @rom = ROM.container(config)
      end

      def rom
        @rom ||= ROM.container(config)
      end

      def migration_container
        ROM.container(config(migrate: true))
      end

      def config(migrate: false)
        return @config if @config

        puts "Database URL #{ENV['DATABASE_URL']}"
        @config ||= ROM::Configuration.new(:sql, ENV['DATABASE_URL'], OPTS)
        register_relations unless migrate
        @config
      end

      def register_relations
        @config.register_relation(Biblio::Db::Relations::Livres)
        @config.register_relation(Biblio::Db::Relations::Auteurs)
      end

      # Defines public methods callables on Module
      module_function :config, :register_relations, :rom, :migration_container, :init_rom!
    end
  end
end
