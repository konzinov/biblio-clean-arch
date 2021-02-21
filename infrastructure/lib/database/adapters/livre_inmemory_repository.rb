module Adapters
  class LivreInMemoryRepository < Repositories::LivreRepository
    attr_accessor :livres, :id

    @@auteurs = {}

    def save(livre)
      id = livre.id.nil? ? count + 1 : livre.id
      @@auteurs[id] = livre
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

    def count
      @@auteurs.size
    end

    def clear!
      @@auteurs.clear
    end
  end
end
