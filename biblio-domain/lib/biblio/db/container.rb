module Biblio
  module Db
    class Container
      extend Dry::Container::Mixin

      def self.init
        if ENV['APP_ENV'] == 'test'
          register(:livre_repository, Biblio::Catalogue::Adapters::LivreInMemoryRepository.new)
        else
          Biblio::Db::Config.init_rom!
          puts 'rom container initialized'
          register(:rom, Biblio::Db::Config.rom)
          register(:livre_repository, Biblio::Catalogue::Adapters::LivreDbRepository.new)
        end
      end
    end
  end
end
