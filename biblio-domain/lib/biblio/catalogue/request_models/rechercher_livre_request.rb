module Biblio
  module Catalogue
    module RequestModels
      class RechercherLivreRequest
        extend Dry::Initializer

        param :titre
      end
    end
  end
end
