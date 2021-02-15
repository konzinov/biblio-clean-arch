module Adapters
  class AuteurDbRepository < Repositories::AuteurRepository
    param :rom, default: proc { Database::Container.resolve(:rom) }

    def save(auteur)
      auteur_relation = rom.relations[:auteurs]
      create_auteur = auteur_relation.command(:create)
      create_auteur.call(nom: auteur.nom, uuid: auteur.uuid)
    end

    def all
      rom.relations[:auteurs].map_to(Entities::Auteur).to_a
    end

    def find(id)
      rom.relations[:auteurs].by_pk(id).map_to(Entities::Auteur).to_a
    end

    def find_by_title(titre)
      rom.relations[:auteurs].titre_like(titre).map_to(Entities::Auteur).to_a
    end

    def clear!
      auteur_relation = rom.relations[:auteurs]
      delete_auteur = auteur_relation.command(:delete)
      delete_auteur.call
    end
  end
end
