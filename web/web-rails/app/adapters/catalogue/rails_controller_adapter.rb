module Catalogue
  class RailsControllerAdapter
    def initialize(controller)
      @controller = controller
    end

    def enregister_livre_params
      @controller.params.require(:catalogue_enregistrer_livre_form).permit(:titre, :auteur, :nb_pages, :date_publication).to_h.symbolize_keys
    end

    def rechercher_livre_params
      @controller.params[:titre]
    end
  end
end
