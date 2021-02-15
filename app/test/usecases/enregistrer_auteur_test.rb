require 'test_helper'

class EnregistrerAuteurTest < Minitest::Test
  def setup
    @repo = Database::Container.resolve(:auteur_repository)
    @repo.clear!
    @presenter = Presenters::EnregistrerAuteurPresenter.new
    @usecase = UseCases::EnregistrerAuteur.new
  end

  def test_enregistrer_auteur_success
    # Given
    demande_creation_auteur = UseCases::EnregistrerAuteurRequest.new(nom: 'Bernard Dadié')

    # When
    enregistrer_auteur_view_model = @usecase.execute(demande_creation_auteur, @presenter)

    # Then
    assert_instance_of ViewModels::EnregistrerAuteurViewModel, enregistrer_auteur_view_model
    assert_equal 'Auteur enregistré avec succès', enregistrer_auteur_view_model.message
    assert_empty enregistrer_auteur_view_model.erreurs
    assert_equal ViewModels::EnregistrerAuteurViewModel::Auteur.new(nom: 'Bernard Dadié'),
                 enregistrer_auteur_view_model.auteur
  end

  def test_enregistrer_auteur_echec_validation
    # Given
    demande_creation_auteur = UseCases::EnregistrerAuteurRequest.new(nom: nil)

    # When
    enregistrer_auteur_view_model = @usecase.execute(demande_creation_auteur, @presenter)

    # Then
    assert_equal "Echec de l'enregistrement de l'auteur", enregistrer_auteur_view_model.message
    assert_equal ['NOM: Nom auteur absent'], enregistrer_auteur_view_model.erreurs
  end

  def test_enregistrer_auteur_echec_repository
    # Given
    mock = Minitest::Mock.new

    def mock.save(_demande)
      false
    end

    enregistrer_auteur_request = UseCases::EnregistrerAuteurRequest.new(nom: 'Bernard Dadié')

    Repositories::AuteurRepository.stub :new, mock do
      @repo = Repositories::AuteurRepository.new
      @usecase = UseCases::EnregistrerAuteur.new(@repo)

      # When
      enregistrer_auteur_view_model = @usecase.execute(enregistrer_auteur_request, @presenter)

      # Then
      assert_equal "Echec de l'enregistrement de l'auteur", enregistrer_auteur_view_model.message
      assert_equal ['DB: repository error'], enregistrer_auteur_view_model.erreurs
    end
  end
end
