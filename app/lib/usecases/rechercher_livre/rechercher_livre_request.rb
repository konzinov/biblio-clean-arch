module UseCases
  class RechercherLivreRequest
    extend Dry::Initializer

    param :titre
  end
end
