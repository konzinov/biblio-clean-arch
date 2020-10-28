require "test_helper"

module Biblio
  module Domain
    module Entities
      class LivreTest < Minitest::Test
        def test_instatiate_livre
          livre = Biblio::Domain::Entities::Livre.new("Question pour un champion", "Julien", 120)
          
          assert livre.titre, "Question pour un champion"
          assert livre.auteur, "Julien"
          assert livre.nb_pages, 120
          
        end
      end
    end
  end
end
