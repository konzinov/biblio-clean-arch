module Biblio::Adapters
  class LivreInMemoryRepository < LivreRepository
    attr_accessor :livres, :id

    @@livres = {}
    @@id = 0

    def save(livre)
      @@id += 1
      @@livres[@@id] = livre
    end

    def all
      @@livres.values
    end

    def find(id)
      @@livres[id]
    end

    def find_by_title(titre)
      @@livres.select { |_, livre| livre.titre.include? titre }.values
    end

    def clear!
      @@livres.clear
    end

  end
end