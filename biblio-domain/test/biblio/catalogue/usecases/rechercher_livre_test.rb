require 'test_helper'

module Biblio
  module Catalogue
    class RechercherLivreTest < Minitest::Test
      def setup
        @repo = Biblio::Db::Container.resolve(:livre_repository)
        @repo.clear!
        @repo.save(Entities::Livre.new(titre: 'Le vieux nègre et la médaille', auteur: 'Bernard Dadié'))
        @repo.save(Entities::Livre.new(titre: 'Le vieux port de marseille', auteur: 'Julien Mounier'))
        @repo.save(Entities::Livre.new(titre: 'Nancy si belle', auteur: 'Vivien Mukandjo'))
        @usecase = UseCases::RechercherLivre.new
      end

      def test_trouver_aucun_livre_sans_titre
        # Given
        rechercher_livre_request = RequestModels::RechercherLivreRequest.new('')
        presenter = Presenters::RechercherLivrePresenter.new

        # When
        recherche_livre_view_model = @usecase.execute(rechercher_livre_request, presenter)

        # Then
        assert_instance_of ViewModels::RechercherLivreViewModel, recherche_livre_view_model
        assert_empty recherche_livre_view_model.livres
        assert_equal 'Aucun livre trouvé', recherche_livre_view_model.message
      end

      def test_trouver_aucun_livre
        # Given
        rechercher_livre_request = RequestModels::RechercherLivreRequest.new('Livre non enregistré')
        presenter = Presenters::RechercherLivrePresenter.new

        # When
        recherche_livre_view_model = @usecase.execute(rechercher_livre_request, presenter)

        # Then
        assert_instance_of ViewModels::RechercherLivreViewModel, recherche_livre_view_model
        assert_empty recherche_livre_view_model.livres
        assert_equal 'Aucun livre trouvé', recherche_livre_view_model.message
      end

      def test_trouver_un_livre
        # Given
        rechercher_livre_request = RequestModels::RechercherLivreRequest.new('Le vieux nègre et la médaille')
        presenter = Presenters::RechercherLivrePresenter.new

        # When
        recherche_livre_view_model = @usecase.execute(rechercher_livre_request, presenter)

        # Then
        assert_instance_of ViewModels::RechercherLivreViewModel, recherche_livre_view_model
        assert_equal 1, recherche_livre_view_model.livres.size
        assert_equal '1 Livres', recherche_livre_view_model.message
        assert_equal recherche_livre_view_model.livres.first, ViewModels::RechercherLivreViewModel::Livre.new(titre: 'Le vieux nègre et la médaille',
                                                                                                              auteur: 'Bernard Dadié')
      end

      def test_trouver_deux_livres
        # Given
        rechercher_livre_request = RequestModels::RechercherLivreRequest.new('Le vieux')
        presenter = Presenters::RechercherLivrePresenter.new

        # When
        recherche_livre_view_model = @usecase.execute(rechercher_livre_request, presenter)

        # Then
        assert_instance_of ViewModels::RechercherLivreViewModel, recherche_livre_view_model
        assert_equal 2, recherche_livre_view_model.livres.size
        assert_equal '2 Livres', recherche_livre_view_model.message
        assert_includes recherche_livre_view_model.livres, ViewModels::RechercherLivreViewModel::Livre.new(titre: 'Le vieux nègre et la médaille',
                                                                                                           auteur: 'Bernard Dadié')

        assert_includes recherche_livre_view_model.livres, ViewModels::RechercherLivreViewModel::Livre.new(titre: 'Le vieux port de marseille',
                                                                                                           auteur: 'Julien Mounier')
      end
    end
  end
end
