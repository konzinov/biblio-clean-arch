module Biblio
  module ViewModels
    class EnregistrerLivreViewModel < ViewModel
      extend Dry::Initializer
      param :message
      option :livre
      option :erreurs

      class Livre
        extend Dry::Initializer
        include Dry::Equalizer(:titre)

        option :titre
        option :auteur
        option :nb_pages, default: proc { 0 }
        option :date_publication, default: proc {'N/A'}
      end
    end
  end
end