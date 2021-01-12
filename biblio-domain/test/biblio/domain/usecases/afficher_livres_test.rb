require 'test_helper'

module Biblio
  module Domain
    class AfficherLivresTest < Minitest::Test
      def setup
        @repo = Biblio::Catalogue::Adapters::LivreDbRepository.new
        @repo.clear!
        @usecase = Biblio::Catalogue::UseCases::AfficherLivres.new(@repo)
      end

      def test_afficher_livres_aucun_livre
        presenter = Biblio::Catalogue::Presenters::AfficherLivresPresenter.new
        afficher_livres_view_model = @usecase.execute(presenter)

        assert_instance_of Biblio::Catalogue::ViewModels::AfficherLivresViewModel, afficher_livres_view_model
        assert_empty afficher_livres_view_model.livres
        assert_equal 'Aucun livre présent', afficher_livres_view_model.resume_nb_livres
      end

      def test_afficher_livres_livres_presents
        @repo.save(Biblio::Catalogue::Entities::Livre.new(titre: 'Le vieux nègre et la médaille', auteur: 'Bernard Dadié'))
        @repo.save(Biblio::Catalogue::Entities::Livre.new(titre: 'Le vieux port de marseille', auteur: 'Julien Mounier'))
        @repo.save(Biblio::Catalogue::Entities::Livre.new(titre: 'Nancy si belle', auteur: 'Vivien Mukandjo'))
        presenter = Biblio::Catalogue::Presenters::AfficherLivresPresenter.new
        afficher_livres_view_model = @usecase.execute(presenter)

        assert_instance_of Biblio::Catalogue::ViewModels::AfficherLivresViewModel, afficher_livres_view_model
        assert_equal '3 Livres', afficher_livres_view_model.resume_nb_livres
        assert_equal ['Le vieux nègre et la médaille', 'Le vieux port de marseille', 'Nancy si belle'],
                     afficher_livres_view_model.livres.map(&:titre)
      end
    end
  end
end
