module Biblio
  module Catalogue
    module RequestModels
      class EnregistrerLivreRequest
        extend Dry::Initializer
        param :titre
        param :auteur
        param :nb_pages
        param :date_publication
      end
    end
  end
end
