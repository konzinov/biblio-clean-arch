module Biblio
  module Catalogue
    module Entities
      class Livre
        include Dry::Equalizer(:titre)
        extend Dry::Initializer

        option :titre
        option :auteur
        option :nb_pages, default: proc { 0 }, optional: true
        option :date_publication, optional: true
      end
    end
  end
end
