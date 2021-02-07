module Biblio
  module Catalogue
    module UseCases
      class AfficherLivres < UseCase
        param :livre_repository, default: proc { Biblio::Db::Container.resolve(:livre_repository) }

        def execute(presenter)
          livres = livre_repository.all
          response = response_model.new(livres)
          presenter.present(response)
        end

        protected

        def response_model
          Biblio::Catalogue::ResponseModels::AfficherLivresResponse
        end
      end
    end
  end
end
