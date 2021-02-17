module Catalogue
  class RechercherLivreForm
    include ActiveModel::Model
    extend Dry::Initializer

    param :titre
  end
end
