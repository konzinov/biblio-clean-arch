class LivresController < ApplicationController
  def initialize
    super
    @livre_repository = Biblio::Adapters::LivreInMemoryRepository.new
    @enregistrer_livre = Biblio::Domain::UseCases::EnregistrerLivre.new(@livre_repository)
    @afficher_livres = Biblio::Domain::UseCases::AfficherLivres.new(@livre_repository)
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

    result = @enregistrer_livre.execute(enregistrer_livre_request)

    @message = if result.success?
                 result.message
               else
                 result.errors.values.join(', ')
               end
  end

  def enregister_livre_params
    params.require(:livre_enregistrer_livre_form).permit(:titre, :auteur).to_h.symbolize_keys
  end
end
