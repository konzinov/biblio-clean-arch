module UseCases
  class AfficherLivres < UseCase
    param :livre_repository, default: proc { Database::Container.resolve(:livre_repository) }

    def execute(presenter)
      livres = livre_repository.all
      response = response_model.new(livres)
      presenter.present(response)
    end

    protected

    def response_model
      AfficherLivresResponse
    end
  end
end
