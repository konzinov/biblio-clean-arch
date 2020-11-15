require 'test_helper'

module Biblio
  module Domain
    class AfficherLivresTest < Minitest::Test
      def setup
        @repo = Biblio::Adapters::LivreInMemoryRepository.new
        @repo.clear!
        @usecase = Biblio::Domain::UseCases::AfficherLivres.new(@repo)
      end

      def test_afficher_livres_aucun_livre
        @repo.clear!
        presenter = Biblio::Presenters::AfficherLivresPresenter.new
        afficher_livres_view_model = @usecase.execute(presenter)

        assert_instance_of Biblio::ViewModels::AfficherLivresViewModel, afficher_livres_view_model
        assert_empty afficher_livres_view_model.livres
        assert_equal afficher_livres_view_model.resume_nb_livres, 'Aucun livre présent'
      end

      def test_afficher_livres_livres_presents
        @repo.save(Biblio::Domain::Entities::Livre.new('Le vieux nègre et la médaille', 'Bernard Dadié', nil, nil))
        @repo.save(Biblio::Domain::Entities::Livre.new('Le vieux port de marseille', 'Julien Mounier', nil, nil))
        @repo.save(Biblio::Domain::Entities::Livre.new('Nancy si belle', 'Vivien Mukandjo', nil, nil))
        presenter = Biblio::Presenters::AfficherLivresPresenter.new
        afficher_livres_view_model = @usecase.execute(presenter)

        assert_instance_of Biblio::ViewModels::AfficherLivresViewModel, afficher_livres_view_model
        assert_equal '3 Livres', afficher_livres_view_model.resume_nb_livres
        assert_equal ['Le vieux nègre et la médaille', 'Le vieux port de marseille', 'Nancy si belle'],
                     afficher_livres_view_model.livres.map(&:titre)
      end
    end
  end
end