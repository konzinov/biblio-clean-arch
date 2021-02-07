module Biblio
  module Catalogue
    module UseCases
      class RechercherLivre < UseCase
        param :livre_repository, default: proc { Biblio::Db::Container.resolve(:livre_repository) }

        def execute(rechercher_livre_request, presenter)
          livres = []
          livres = livre_repository.find_by_title(rechercher_livre_request.titre) unless rechercher_livre_request.titre.empty?
          response = response_model.new(livres)
          presenter.present(response)
        end

        protected

        def request_model
          RequestModels::RechercherLivreRequest
        end

        def response_model
          ResponseModels::RechercherLivreResponse
        end
      end
    end
  end
end
