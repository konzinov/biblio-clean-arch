require 'test_helper'

module Biblio
  module Domain
    module UseCases
      class RechercherLivreTest < Minitest::Test
        def setup
          @repo = Biblio::Adapters::LivreInMemoryRepository.new
          @repo.clear!
          @repo.save(Biblio::Domain::Entities::Livre.new(titre: 'Le vieux nègre et la médaille', auteur: 'Bernard Dadié'))
          @repo.save(Biblio::Domain::Entities::Livre.new(titre: 'Le vieux port de marseille', auteur: 'Julien Mounier'))
          @repo.save(Biblio::Domain::Entities::Livre.new(titre: 'Nancy si belle', auteur: 'Vivien Mukandjo'))
          @usecase = Biblio::Domain::UseCases::RechercherLivre.new(@repo)
        end

        def test_trouver_aucun_livre_sans_titre
          rechercher_livre_request = Biblio::RequestModels::RechercherLivreRequest.new('')
          presenter = Biblio::Presenters::RechercherLivrePresenter.new
          recherche_livre_view_model = @usecase.execute(rechercher_livre_request, presenter)

          assert_instance_of Biblio::ViewModels::RechercherLivreViewModel, recherche_livre_view_model
          assert_empty recherche_livre_view_model.livres
          assert_equal 'Aucun livre trouvé', recherche_livre_view_model.message
        end

        def test_trouver_aucun_livre
          rechercher_livre_request = Biblio::RequestModels::RechercherLivreRequest.new('Livre non enregistré')
          presenter = Biblio::Presenters::RechercherLivrePresenter.new
          recherche_livre_view_model = @usecase.execute(rechercher_livre_request, presenter)

          assert_instance_of Biblio::ViewModels::RechercherLivreViewModel, recherche_livre_view_model
          assert_empty recherche_livre_view_model.livres
          assert_equal 'Aucun livre trouvé', recherche_livre_view_model.message
        end

        def test_trouver_un_livre
          rechercher_livre_request = Biblio::RequestModels::RechercherLivreRequest.new('Le vieux nègre et la médaille')
          presenter = Biblio::Presenters::RechercherLivrePresenter.new
          recherche_livre_view_model = @usecase.execute(rechercher_livre_request, presenter)

          assert_instance_of Biblio::ViewModels::RechercherLivreViewModel, recherche_livre_view_model
          assert_equal 1, recherche_livre_view_model.livres.size
          assert_equal '1 Livres', recherche_livre_view_model.message
          assert_equal recherche_livre_view_model.livres.first, Biblio::ViewModels::RechercherLivreViewModel::Livre.new(titre: 'Le vieux nègre et la médaille',
                                                                                                                        auteur: 'Bernard Dadié')
        end

        def test_trouver_deux_livres
          rechercher_livre_request = Biblio::RequestModels::RechercherLivreRequest.new('Le vieux')
          presenter = Biblio::Presenters::RechercherLivrePresenter.new
          recherche_livre_view_model = @usecase.execute(rechercher_livre_request, presenter)

          assert_instance_of Biblio::ViewModels::RechercherLivreViewModel, recherche_livre_view_model
          assert_equal 2, recherche_livre_view_model.livres.size
          assert_equal '2 Livres', recherche_livre_view_model.message
          assert_includes recherche_livre_view_model.livres, Biblio::ViewModels::RechercherLivreViewModel::Livre.new(titre: 'Le vieux nègre et la médaille',
                                                                                                                     auteur: 'Bernard Dadié')

          assert_includes recherche_livre_view_model.livres, Biblio::ViewModels::RechercherLivreViewModel::Livre.new(titre: 'Le vieux port de marseille',
                                                                                                                     auteur: 'Julien Mounier')
        end
      end
    end
  end
end
