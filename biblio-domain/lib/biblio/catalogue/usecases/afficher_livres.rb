module Biblio
  module Catalogue
    module UseCases
      class AfficherLivres < UseCase
        param :livre_repository

        def execute(presenter)
          livres = livre_repository.all
          response = response_model.new(livres)
          presenter.present(response)
        end

        private

        def response_model
          Biblio::Catalogue::ResponseModels::AfficherLivresResponse
        end
      end
    end
  end
end
