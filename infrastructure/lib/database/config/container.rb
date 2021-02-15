module Database
  class Container
    extend Dry::Container::Mixin

    def self.init
      if with_database?
        Database::Config.init_rom!
        puts '[PGSQL] rom container initialized'
        register(:rom, Database::Config.rom)
        register(:livre_repository, Adapters::LivreDbRepository.new)
        register(:auteur_repository, Adapters::AuteurDbRepository.new)
      else
        puts '[IN_MEMORY] rom container initialized'
        register(:livre_repository, Adapters::LivreInMemoryRepository.new)
        register(:auteur_repository, Adapters::AuteurInMemoryRepository.new)
      end
    end

    def self.with_database?
      !ENV['DATABASE_URL'].nil?
    end
  end
end
