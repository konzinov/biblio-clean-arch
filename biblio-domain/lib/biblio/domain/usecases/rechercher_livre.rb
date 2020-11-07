module Biblio
  module Domain
    module UseCases
      class RechercherLivre < UseCase
        param :livre_repository

        def execute(rechercher_livre_request, presenter)
          livres = livre_repository.find_by_title(rechercher_livre_request.titre)
          response = response_class.new(livres)
          presenter.present response
        end

        def response_class
          Biblio::ResponseModels::RechercherLivreResponse
        end
      end
    end
  end
end