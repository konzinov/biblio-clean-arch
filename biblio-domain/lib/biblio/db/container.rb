module Biblio
  module Db
    class Container
      extend Dry::Container::Mixin

      def self.init
        if ENV['APP_ENV'] == 'test'
          puts '[IN_MEMORY] rom container initialized'
          register(:livre_repository, Biblio::Catalogue::Adapters::LivreInMemoryRepository.new)
          register(:auteur_repository, Biblio::Catalogue::Adapters::AuteurInMemoryRepository.new)
        else
          Biblio::Db::Config.init_rom!
          puts '[PGSQL] rom container initialized'
          puts 'rom container initialized'
          register(:rom, Biblio::Db::Config.rom)
          register(:livre_repository, Biblio::Catalogue::Adapters::LivreDbRepository.new)
          register(:auteur_repository, Biblio::Catalogue::Adapters::AuteurDbRepository.new)
        end
      end
    end
  end
end
