module Catalogue
  class LivreService
    # include Biblio::Catalogue

    # Constructeur
    # +entry_point_port+ port de point d'entree (rest, controlleur, api, cli)
    def initialize(entry_point_port)
      @entry_point_port = entry_point_port
      @enregistrer_livre = UseCases::EnregistrerLivre.new
      @rechercher_livre = UseCases::RechercherLivre.new
      @afficher_livres = UseCases::AfficherLivres.new
    end

    def creer_livre
      Catalogue::EnregistrerLivreForm.new
    end

    def afficher_livres
      presenter = Presenters::AfficherLivresPresenter.new
      @afficher_livres.execute(presenter)
    end

    def enregistrer_livre
      form = Catalogue::EnregistrerLivreForm.new(@entry_point_port.enregister_livre_params)

      enregistrer_livre_request = form.enregistrer_livre_request

      presenter = Presenters::EnregistrerLivrePresenter.new
      @enregistrer_livre.execute(enregistrer_livre_request, presenter)
    end

    def rechercher_livre
      if (titre = @entry_point_port.rechercher_livre_params)
        presenter = Presenters::RechercherLivrePresenter.new
        request_model = UseCases::RechercherLivreRequest.new(titre)
        view_model = @rechercher_livre.execute(request_model, presenter)
        form = Catalogue::RechercherLivreForm.new(titre)
      else
        view_model = ViewModels::RechercherLivreViewModel.new(nil)
        form = Catalogue::RechercherLivreForm.new(nil)
      end

      [view_model, form]
    end
  end
end
