require 'test_helper'

class LivresControllerTest < ActionDispatch::IntegrationTest
  def setup
    @repo = Database::Container.resolve(:livre_repository)
    @repo.clear!
  end

  test 'should show index with no book' do
    get '/catalogue/livres'

    assert_response :success
    assert_instance_of ViewModels::AfficherLivresViewModel, assigns(:view_model)
    assert_select 'h3', 'Aucun livre présent'
    assert_select 'ul', nil
  end

  test 'should show index with 2 books' do
    @repo.save Entities::Livre.new(titre: 'Le vieux nègre et la médaille', auteur: 'Bernard Dadié')
    @repo.save Entities::Livre.new(titre: 'Le vieux port de marseille', auteur: 'Julien Mounier')
    get '/catalogue/livres'

    assert_instance_of ViewModels::AfficherLivresViewModel, assigns(:view_model)
    assert_response :success
    assert_select 'ul', 'Le vieux nègre et la médailleLe vieux port de marseille'
  end

  test 'should create livre' do
    post '/catalogue/livres', params: { catalogue_enregistrer_livre_form: { titre: 'Les bouts de bois de Dieu',
                                                                            auteur: 'Sembene Ousmane',
                                                                            nb_pages: 150,
                                                                            date_publication: Date.new(1955, 1, 1) } }

    assert_response :success
    assert_instance_of ViewModels::EnregistrerLivreViewModel, assigns(:view_model)
    assert_select 'h1', 'Livre enregistré avec succès'
  end

  test 'should present new livre form' do
    get '/catalogue/livres/new'
    assert_response :ok
  end

  test 'should show missing title when creating book' do
    post '/catalogue/livres', params: { catalogue_enregistrer_livre_form: { titre: nil,
                                                                            auteur: 'Sembene Ousmane',
                                                                            nb_pages: 150,
                                                                            date_publication: Date.new(1955, 1, 1) } }

    assert_response :bad_request
    assert_instance_of ViewModels::EnregistrerLivreViewModel, assigns(:view_model)
    assert_select 'h1', "Echec de l'enregistrement du livre"
    assert_select 'ul', /Titre absent/
  end

  test 'should not find any book with missing title' do
    get '/catalogue/livres/search', params: { titre: nil }

    assert_response :missing
    assert_instance_of ViewModels::RechercherLivreViewModel, assigns(:view_model)
    assert_select 'span', nil
    assert_select 'ul', nil
  end

  test 'should not find any book' do
    @repo.save Entities::Livre.new(titre: 'Le vieux nègre et la médaille', auteur: 'Bernard Dadié')
    get '/catalogue/livres/search', params: { titre: 'Livre inexistant' }

    assert_response :missing
    assert_instance_of ViewModels::RechercherLivreViewModel, assigns(:view_model)
    assert_select 'span', 'Aucun livre trouvé'
    assert_select 'ul', nil
  end

  test 'should find one book' do
    @repo.save Entities::Livre.new(titre: 'Le vieux nègre et la médaille', auteur: 'Bernard Dadié')
    @repo.save Entities::Livre.new(titre: 'Le vieux port de marseille', auteur: 'Julien Mounier')
    @repo.save Entities::Livre.new(titre: 'Nancy si belle', auteur: 'Vivien Mukandjo')
    get '/catalogue/livres/search', params: { titre: 'Nancy si belle' }

    assert_response :success
    assert_instance_of ViewModels::RechercherLivreViewModel, assigns(:view_model)
    assert_select 'span', '1 Livres'
    assert_select 'ul', 'Nancy si belle'
  end

  test 'should find all books with title starting with Le vieux' do
    @repo.save Entities::Livre.new(titre: 'Le vieux nègre et la médaille', auteur: 'Bernard Dadié')
    @repo.save Entities::Livre.new(titre: 'Le vieux port de marseille', auteur: 'Julien Mounier')
    @repo.save Entities::Livre.new(titre: 'Nancy si belle', auteur: 'Vivien Mukandjo')
    get '/catalogue/livres/search', params: { titre: 'Le vieux' }

    assert_response :success
    assert_instance_of ViewModels::RechercherLivreViewModel, assigns(:view_model)
    assert_select 'span', '2 Livres'
    assert_select 'ul', 'Le vieux nègre et la médailleLe vieux port de marseille'
  end
end
