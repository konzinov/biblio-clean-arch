module Biblio
  module Catalogue
    module ViewModels
      class EnregistrerAuteurViewModel < ViewModel
        extend Dry::Initializer
        param :message
        option :auteur
        option :erreurs

        class Auteur
          include Dry::Equalizer(:nom)
          extend Dry::Initializer

          option :nom
        end
      end
    end
  end
end
