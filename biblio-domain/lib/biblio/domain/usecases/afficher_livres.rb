module Biblio
  module Domain
    module UseCases
      class   AfficherLivres < UseCase
        param :livre_repository

        def execute(presenter)
          livres = livre_repository.all
          response_model = Biblio::ResponseModels::AfficherLivresResponse.new(livres)
          presenter.present(response_model)
        end
      end
    end
  end
end
