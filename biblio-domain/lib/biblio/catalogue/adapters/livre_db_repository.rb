module Biblio
  module Catalogue
    module Adapters
      class LivreDbRepository < LivreRepository
        param :rom, default: proc { Biblio::Db::Container.resolve(:rom) }

        def save(livre)
          livre_relation = rom.relations[:livres]
          create_livre = livre_relation.command(:create)
          create_livre.call(titre: livre.titre, auteur: livre.auteur, nb_pages: livre.nb_pages)
        end

        def all
          rom.relations[:livres].map_to(Entities::Livre).to_a
        end

        def find(id)
          rom.relations[:livres].by_pk(id).map_to(Entities::Livre).to_a
        end

        def find_by_title(titre)
          rom.relations[:livres].titre_like(titre).map_to(Entities::Livre).to_a
        end

        def clear!
          livre_relation = rom.relations[:livres]
          delete_livre = livre_relation.command(:delete)
          delete_livre.call
        end
      end
    end
  end
end
