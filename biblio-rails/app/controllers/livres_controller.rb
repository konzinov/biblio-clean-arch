class LivresController < ApplicationController
  
  def initialize
    super
    @livre_repository = Biblio::Adapters::LivreInMemoryRepository.new
    @enregistrer_livre = Biblio::Domain::UseCases::EnregistrerLivre.new(@livre_repository)
  end
  
  def index
    @livres = @livre_repository.all
    
    @livres.each do |livre|
      puts livre.titre.class
    end
    
    @livres
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
    @presenter =
    
    if result.success?
      @message = result.message
    else
      @message = result.errors.values.join(', ')
    end
    
  end
  
  def enregister_livre_params
    params.require(:livre_enregistrer_livre_form).permit(:titre, :auteur).to_h.symbolize_keys
  end
  
end