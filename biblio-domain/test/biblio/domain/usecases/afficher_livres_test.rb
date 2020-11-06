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
        presenter = Biblio::Presenters::AfficherLivresPresenter.new
        afficher_livres_view_model = @usecase.execute(presenter)

        assert_instance_of Biblio::ViewModels::AfficherLivresViewModel, afficher_livres_view_model
        assert_empty afficher_livres_view_model.livres
        assert_equal afficher_livres_view_model.resume_nb_livres, 'Aucun livre présent'
      end

      def test_afficher_livres_livres_presents

      end
    end
  end
end