module Biblio
  module Domain
    module UseCases
      class RechercherLivre < UseCase
        param :livre_repository
        
        def execute(rechercher_livre_request)
          livre = livre_repository.find_by_title(rechercher_livre_request.titre)

          response_class.build(titre: livre.titre,
                               auteur: livre.auteur,
                               nb_pages: livre.nb_pages,
                               date_publication: livre.date_publication)
        end
        
        def response_class
          Biblio::ResponseModels::RechercherLivreResponse
        end
      end
    end
  end
end