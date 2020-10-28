require 'test_helper'

module Biblio
  module Domain
    module UseCases
      class EnregistrerLivreTest < Minitest::Test
        def setup
          @repo = Biblio::Adapters::LivreInMemoryRepository.new
          @usecase = Biblio::Domain::UseCases::EnregistrerLivre.new(@repo)
        end
        
        def test_enregistrer_livre_success
          demande_creation_livre = Biblio::RequestModels::EnregistrerLivreRequest.new('Le Pagne noir',
                                                                                      'Bernard Dadié',
                                                                                      120,
                                                                                      Date.new(1955, 1, 1))
          result = @usecase.execute(demande_creation_livre)
          assert result.success?
          assert_equal result.message, 'Livre enregistré avec success'
        end
        
        def test_enregistrer_livre_echec_validation
          demande_creation_livre = Biblio::RequestModels::EnregistrerLivreRequest.new(nil, nil, nil, nil)
          
          result = @usecase.execute(demande_creation_livre)
          refute result.success?
          assert_equal result.message,'Erreurs rencontrées'
          assert result.errors.has_key? :titre
        end
        
        def test_enregistre_livre_echec_repository
          mock = Minitest::Mock.new
          def mock.save(demande); false; end
          
          enregistrer_livre_request = Biblio::RequestModels::EnregistrerLivreRequest.new('Le pagne Noir',
                                                                                         'Bernard Dadié', nil, nil)

          Biblio::Adapters::LivreInMemoryRepository.stub :new, mock do
            @repo = Biblio::Adapters::LivreInMemoryRepository.new
            @usecase = Biblio::Domain::UseCases::EnregistrerLivre.new(@repo)
            
            result = @usecase.execute(enregistrer_livre_request)
            refute result.success?
            assert_equal result.message,'Enregistrement du livre impossible'
          end
        end
      end
    end
  end
end