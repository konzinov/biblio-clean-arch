module Biblio
  module Catalogue
    module Adapters
      class AuteurInMemoryRepository < AuteurRepository
        attr_accessor :livres, :id

        @@auteurs = {}
        @@id = 0

        def save(auteur)
          @@id += 1
          @@auteurs[@@id] = auteur
        end

        def all
          @@auteurs.values
        end

        def find(id)
          @@auteurs[id]
        end

        def find_by_nom(nom)
          @@auteurs.select { |_, auteur| auteur.nom.include? nom }.values
        end

        def clear!
          @@auteurs.clear
        end
      end
    end
  end
end
