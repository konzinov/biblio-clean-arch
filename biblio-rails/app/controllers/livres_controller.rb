class LivresController < ApplicationController
  def initialize
    super
    @livre_repository = Biblio::Adapters::LivreInMemoryRepository.new
    @enregistrer_livre = Biblio::Domain::UseCases::EnregistrerLivre.new(@livre_repository)
    @afficher_livres = Biblio::Domain::UseCases::AfficherLivres.new(@livre_repository)
    @rechercher_livres =Biblio::Domain::UseCases::RechercherLivre.new(@livre_repository)
  end

  def index
    presenter = Biblio::Presenters::AfficherLivresPresenter.new
    @view_model = @afficher_livres.execute(presenter)
  end

  def new
    @form = Livre::EnregistrerLivreForm.new
  end

  def create
    @form = Livre::EnregistrerLivreForm.new(enregister_livre_params)

    enregistrer_livre_request = Biblio::RequestModels::EnregistrerLivreRequest.new(@form.titre,
                                                                                   @form.auteur,
                                                                                   @form.nb_pages,
                                                                                   @form.date_publication)
    presenter = Biblio::Presenters::EnregistrerLivrePresenter.new
    @enregistrer_livre_view_model = @enregistrer_livre.execute(enregistrer_livre_request, presenter)
  end

  def search
    if params[:titre]
      titre = rechercher_livre_params
      presenter = Biblio::Presenters::RechercherLivrePresenter.new
      request_model = Biblio::RequestModels::RechercherLivreRequest.new(titre)
      @view_model = @rechercher_livres.execute(request_model, presenter)
      @form = Livre::RechercherLivreForm.new(titre)
      render 'search'
    else
      @view_model = Biblio::ViewModels::RechercherLivreViewModel.new(nil)
      @form = Livre::RechercherLivreForm.new(nil)
    end
  end

  private

  def rechercher_livre_params
    params.require(:titre)
  end

  def enregister_livre_params
    params.require(:livre_enregistrer_livre_form).permit(:titre, :auteur).to_h.symbolize_keys
  end
end
