module Biblio
  module RequestModels
    class RechercherLivreRequest
      extend Dry::Initializer

      param :titre
    end
  end
end
