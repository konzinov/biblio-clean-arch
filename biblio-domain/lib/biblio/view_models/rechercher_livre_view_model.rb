module Biblio
  module ViewModels
    class RechercherLivreViewModel < ViewModel
      extend Dry::Initializer
      param :message
      param :livres, default: proc { [] }

      class Livre
        include Dry::Equalizer(:titre, :auteur)
        extend Dry::Initializer

        option :titre
        option :auteur
      end
    end
  end
end