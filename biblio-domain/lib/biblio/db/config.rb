require 'rom-sql'

module Biblio
  module Db
    module Config
      OPTS = {
        host: '127.0.0.1',
        adapter: :sql,
        username: 'postgres',
        password: 'root',
        encoding: 'UTF8',
        scheme: 'postgres',
        server_version: '12.0'
      }.freeze

      def rom
        @rom ||= ROM.container(config)
      end

      def config
        return @config if @config

        @config ||= ROM::Configuration.new(:sql, 'postgres://127.0.0.1:5432/bibliodb', OPTS)
        @config.register_relation(Biblio::Db::Relations::Livres)
        @config
      end

      module_function :config, :rom
    end
  end
end
