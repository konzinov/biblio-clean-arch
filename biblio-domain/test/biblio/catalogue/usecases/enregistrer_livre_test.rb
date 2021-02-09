require 'test_helper'

module Biblio
  module Catalogue
    class EnregistrerLivreTest < Minitest::Test
      def setup
        @repo = Biblio::Db::Container.resolve(:livre_repository)
        @repo.clear!
        @usecase = Biblio::Catalogue::UseCases::EnregistrerLivre.new
      end

      def test_enregistrer_livre_success
        # Given
        demande_creation_livre = RequestModels::EnregistrerLivreRequest.new('Le Pagne noir',
                                                                            'Bernard Dadié',
                                                                            120,
                                                                            Date.new(1955, 1, 1))

        presenter = Presenters::EnregistrerLivrePresenter.new

        # When
        enregistrer_livre_view_model = @usecase.execute(demande_creation_livre, presenter)

        # Then
        assert_instance_of ViewModels::EnregistrerLivreViewModel, enregistrer_livre_view_model
        assert_equal 'Livre enregistré avec succès', enregistrer_livre_view_model.message
        assert_empty enregistrer_livre_view_model.erreurs
        assert_equal ViewModels::EnregistrerLivreViewModel::Livre.new(titre: 'Le Pagne noir', auteur: nil, nb_pages: nil, date_publication: nil),
                     enregistrer_livre_view_model.livre
      end

      def test_enregistrer_livre_echec_validation
        # Given
        demande_creation_livre = RequestModels::EnregistrerLivreRequest.new(nil, nil, nil, nil)

        presenter = Presenters::EnregistrerLivrePresenter.new

        # When
        enregistrer_livre_view_model = @usecase.execute(demande_creation_livre, presenter)

        # Then
        assert_equal "Echec de l'enregistrement du livre", enregistrer_livre_view_model.message
        assert_equal ['TITRE: Titre absent'], enregistrer_livre_view_model.erreurs
      end

      def test_enregistrer_livre_echec_repository
        # Given
        mock = Minitest::Mock.new

        def mock.save(_demande)
          false
        end

        enregistrer_livre_request = RequestModels::EnregistrerLivreRequest.new('Le pagne Noir', 'Bernard Dadié', nil, nil)

        Adapters::LivreRepository.stub :new, mock do
          @repo = Adapters::LivreRepository.new
          @usecase = UseCases::EnregistrerLivre.new(@repo)

          # When
          presenter = Presenters::EnregistrerLivrePresenter.new
          enregistrer_livre_view_model = @usecase.execute(enregistrer_livre_request, presenter)

          # Then
          assert_equal "Echec de l'enregistrement du livre", enregistrer_livre_view_model.message
          assert_equal ['DB: repository error'], enregistrer_livre_view_model.erreurs
        end
      end
    end
  end
end
