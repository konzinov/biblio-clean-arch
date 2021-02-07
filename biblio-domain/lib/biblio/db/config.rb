require 'rom-sql'

module Biblio
  module Db
    module Config
      OPTS = {
        username: 'postgres',
        password: 'root',
        encoding: 'UTF8',
        scheme: 'postgres',
        server_version: '12.0'
      }.freeze

      def init_rom!
        @rom = ROM.container(config)
      end

      def rom
        @rom ||= ROM.container(config)
      end

      def config
        return @config if @config

        puts "Database URL #{ENV['DATABASE_URL']}"
        @config ||= ROM::Configuration.new(:sql, ENV['DATABASE_URL'], OPTS)
        @config.register_relation(Biblio::Db::Relations::Livres)
        @config
      end

      # Defines public methods callables on Module
      module_function :config, :rom, :init_rom!
    end
  end
end
