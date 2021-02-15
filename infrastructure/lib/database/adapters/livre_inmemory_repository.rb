module Adapters
  class LivreInMemoryRepository < Repositories::LivreRepository
    attr_accessor :livres, :id

    @@auteurs = {}
    @@id = 0

    def save(livre)
      @@id += 1
      @@auteurs[@@id] = livre
    end

    def all
      @@auteurs.values
    end

    def find(id)
      @@auteurs[id]
    end

    def find_by_title(titre)
      @@auteurs.select { |_, livre| livre.titre.include? titre }.values
    end

    def clear!
      @@auteurs.clear
    end
  end
end
