require 'test_helper'

class AfficherLivresTest < Minitest::Test
  def setup
    @repo = Database::Container.resolve(:livre_repository)
    @repo.clear!
    @usecase = UseCases::AfficherLivres.new
  end

  def test_afficher_livres_aucun_livre
    # Given
    presenter = Presenters::AfficherLivresPresenter.new

    # When
    afficher_livres_view_model = @usecase.execute(presenter)

    # Then
    assert_instance_of ViewModels::AfficherLivresViewModel, afficher_livres_view_model
    assert_empty afficher_livres_view_model.livres
    assert_equal 'Aucun livre présent', afficher_livres_view_model.resume_nb_livres
  end

  def test_afficher_livres_livres_presents
    # Given
    @repo.save(Entities::Livre.new(titre: 'Le vieux nègre et la médaille', auteur: 'Bernard Dadié'))
    @repo.save(Entities::Livre.new(titre: 'Le vieux port de marseille', auteur: 'Julien Mounier'))
    @repo.save(Entities::Livre.new(titre: 'Nancy si belle', auteur: 'Vivien Mukandjo'))
    presenter = Presenters::AfficherLivresPresenter.new

    # When
    afficher_livres_view_model = @usecase.execute(presenter)

    # Then
    assert_instance_of ViewModels::AfficherLivresViewModel, afficher_livres_view_model
    assert_equal '3 Livres', afficher_livres_view_model.resume_nb_livres
    assert_equal ['Le vieux nègre et la médaille', 'Le vieux port de marseille', 'Nancy si belle'],
                 afficher_livres_view_model.livres.map(&:titre)
  end
end
