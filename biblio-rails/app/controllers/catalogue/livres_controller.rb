module Catalogue
  class LivresController < ApplicationController
    def initialize
      super
      @livre_repository = Biblio::Catalogue::Adapters::LivreDbRepository.new
      @enregistrer_livre = Biblio::Catalogue::UseCases::EnregistrerLivre.new(@livre_repository)
      @afficher_livres = Biblio::Catalogue::UseCases::AfficherLivres.new(@livre_repository)
      @rechercher_livre = Biblio::Catalogue::UseCases::RechercherLivre.new(@livre_repository)
    end

    def index
      presenter = Biblio::Catalogue::Presenters::AfficherLivresPresenter.new
      @view_model = @afficher_livres.execute(presenter)
    end

    def new
      @form = Catalogue::EnregistrerLivreForm.new
    end

    def create
      @form = Catalogue::EnregistrerLivreForm.new(enregister_livre_params)

      enregistrer_livre_request = Biblio::Catalogue::RequestModels::EnregistrerLivreRequest.new(@form.titre,
                                                                                                @form.auteur,
                                                                                                @form.nb_pages,
                                                                                                @form.date_publication)
      presenter = Biblio::Catalogue::Presenters::EnregistrerLivrePresenter.new
      @view_model = @enregistrer_livre.execute(enregistrer_livre_request, presenter)
      render status: :bad_request if @view_model.erreurs.any?
    end

    def search
      if (titre = params[:titre])
        presenter = Biblio::Catalogue::Presenters::RechercherLivrePresenter.new
        request_model = Biblio::Catalogue::RequestModels::RechercherLivreRequest.new(titre)
        @view_model = @rechercher_livre.execute(request_model, presenter)
        @form = Catalogue::RechercherLivreForm.new(titre)
      else
        @view_model = Biblio::Catalogue::ViewModels::RechercherLivreViewModel.new(nil)
        @form = Catalogue::RechercherLivreForm.new(nil)
      end

      render status: :not_found if @view_model.livres.empty?
    end

    private

    def enregister_livre_params
      params.require(:catalogue_enregistrer_livre_form).permit(:titre, :auteur, :nb_pages).to_h.symbolize_keys
    end
  end
end
