require 'test_helper'

module Biblio
  module Domain
    module UseCases
      class EnregistrerLivreTest < Minitest::Test
        def setup
          @repo = Biblio::Catalogue::Adapters::LivreInMemoryRepository.new
          @repo.clear!
          @usecase = Biblio::Catalogue::UseCases::EnregistrerLivre.new(@repo)
        end

        def test_enregistrer_livre_success
          demande_creation_livre = Biblio::Catalogue::RequestModels::EnregistrerLivreRequest.new('Le Pagne noir',
                                                                                      'Bernard Dadié',
                                                                                      120,
                                                                                      Date.new(1955, 1, 1))
          presenter = Biblio::Catalogue::Presenters::EnregistrerLivrePresenter.new
          enregistrer_livre_view_model = @usecase.execute(demande_creation_livre, presenter)

          assert_instance_of Biblio::ViewModels::EnregistrerLivreViewModel, enregistrer_livre_view_model
          assert_equal 'Livre enregistré avec succès', enregistrer_livre_view_model.message
          assert_empty enregistrer_livre_view_model.erreurs
          assert_equal Biblio::ViewModels::EnregistrerLivreViewModel::Livre.new(titre: 'Le Pagne noir', auteur: nil, nb_pages: nil, date_publication: nil),
                       enregistrer_livre_view_model.livre
        end

        def test_enregistrer_livre_echec_validation
          demande_creation_livre = Biblio::Catalogue::RequestModels::EnregistrerLivreRequest.new(nil, nil, nil, nil)

          presenter = Biblio::Catalogue::Presenters::EnregistrerLivrePresenter.new
          enregistrer_livre_view_model = @usecase.execute(demande_creation_livre, presenter)

          assert_equal "Echec de l'enregistrement du livre", enregistrer_livre_view_model.message
          assert_equal ['TITRE: Titre absent'], enregistrer_livre_view_model.erreurs
        end

        def test_enregistrer_livre_echec_repository
          mock = Minitest::Mock.new
          def mock.save(_demande)
            false
          end

          enregistrer_livre_request = Biblio::Catalogue::RequestModels::EnregistrerLivreRequest.new('Le pagne Noir', 'Bernard Dadié', nil, nil)

          Biblio::Catalogue::Adapters::LivreInMemoryRepository.stub :new, mock do
            @repo = Biblio::Catalogue::Adapters::LivreInMemoryRepository.new
            @usecase = Biblio::Catalogue::UseCases::EnregistrerLivre.new(@repo)

            presenter = Biblio::Catalogue::Presenters::EnregistrerLivrePresenter.new
            enregistrer_livre_view_model = @usecase.execute(enregistrer_livre_request, presenter)
            assert_equal "Echec de l'enregistrement du livre", enregistrer_livre_view_model.message
            assert_equal ['DB: repository error'], enregistrer_livre_view_model.erreurs
          end
        end
      end
    end
  end
end
