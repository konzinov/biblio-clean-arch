require 'test_helper'

module Biblio
  module Domain
    module UseCases
      class EnregistrerLivreTest < Minitest::Test
        def setup
          @repo = Biblio::Adapters::LivreInMemoryRepository.new
          @repo.clear!
          @usecase = Biblio::Domain::UseCases::EnregistrerLivre.new(@repo)
        end
        
        def test_enregistrer_livre_success
          demande_creation_livre = Biblio::RequestModels::EnregistrerLivreRequest.new('Le Pagne noir',
                                                                                      'Bernard Dadié',
                                                                                      120,
                                                                                      Date.new(1955, 1, 1))
          presenter = Biblio::Presenters::EnregistrerLivrePresenter.new
          enregistrer_livre_view_model = @usecase.execute(demande_creation_livre, presenter)

          assert_instance_of Biblio::ViewModels::EnregistrerLivreViewModel, enregistrer_livre_view_model
          assert_equal enregistrer_livre_view_model.message, 'Livre enregistré avec succès'
          assert_empty enregistrer_livre_view_model.erreurs
          assert_equal enregistrer_livre_view_model.livre, Biblio::ViewModels::EnregistrerLivreViewModel::Livre.new(titre: 'Le Pagne noir',
                                                                                                                    auteur: nil,
                                                                                                                    nb_pages: nil,
                                                                                                                    date_publication: nil)
        end
        
        def test_enregistrer_livre_echec_validation
          demande_creation_livre = Biblio::RequestModels::EnregistrerLivreRequest.new(nil, nil, nil, nil)

          presenter = Biblio::Presenters::EnregistrerLivrePresenter.new
          enregistrer_livre_view_model = @usecase.execute(demande_creation_livre, presenter)

          assert_equal enregistrer_livre_view_model.message, "Echec de l'enregistrement du livre"
          assert_equal enregistrer_livre_view_model.erreurs, ["TITRE: Titre absent"]
        end

        def test_enregistrer_livre_echec_repository
          mock = Minitest::Mock.new
          def mock.save(demande); false; end

          enregistrer_livre_request = Biblio::RequestModels::EnregistrerLivreRequest.new('Le pagne Noir', 'Bernard Dadié', nil, nil)

          Biblio::Adapters::LivreInMemoryRepository.stub :new, mock do
            @repo = Biblio::Adapters::LivreInMemoryRepository.new
            @usecase = Biblio::Domain::UseCases::EnregistrerLivre.new(@repo)

            presenter = Biblio::Presenters::EnregistrerLivrePresenter.new
            enregistrer_livre_view_model = @usecase.execute(enregistrer_livre_request, presenter)
            assert_equal enregistrer_livre_view_model.message, "Echec de l'enregistrement du livre"
            assert_equal enregistrer_livre_view_model.erreurs, ["DB: repository error"]
          end
        end
      end
    end
  end
end