require 'test_helper'

module Biblio
  module Domain
    module Entities
      class LivreTest < Minitest::Test
        def test_instantiate_livre
          livre = Biblio::Domain::Entities::Livre.new(titre: 'Question pour un champion', auteur: 'Julien', nb_pages: 120)

          assert livre.titre, 'Question pour un champion'
          assert livre.auteur, 'Julien'
          assert livre.nb_pages, 120
        end
      end
    end
  end
end
