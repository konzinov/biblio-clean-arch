require 'test_helper'

module Biblio
  module Domain
    module UseCases
      class RechercherLivreTest < Minitest::Test
        def setup
          @repo = Biblio::Adapters::LivreInMemoryRepository.new
          @repo.clear!
          @repo.save(Biblio::Domain::Entities::Livre.new('Le vieux nègre et la médaille', 'Bernard Dadié', nil, nil))
          @usecase = Biblio::Domain::UseCases::RechercherLivre.new(@repo)
        end
        
        def test_executer
          rechercher_livre_request = Biblio::RequestModels::RechercherLivreRequest.new('Le vieux nègre et la médaille')
          result = @usecase.execute(rechercher_livre_request)
          
          assert result.success?
          assert result.titre == 'Le vieux nègre et la médaille'
          assert result.auteur == 'Bernard Dadié'
          assert_nil result.nb_pages
          assert_nil result.date_publication
        end
      end
    end
  end
end