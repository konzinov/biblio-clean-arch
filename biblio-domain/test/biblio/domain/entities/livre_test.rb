require 'test_helper'

module Biblio
  module Domain
    module Entities
      class LivreTest < Minitest::Test
        def test_instantiate_livre
          livre = Biblio::Catalogue::Entities::Livre.new(titre: 'Question pour un champion', auteur: 'Julien', nb_pages: 120)

          assert_equal 'Question pour un champion', livre.titre
          assert_equal 'Julien', livre.auteur
          assert_equal 120, livre.nb_pages
        end
      end
    end
  end
end
