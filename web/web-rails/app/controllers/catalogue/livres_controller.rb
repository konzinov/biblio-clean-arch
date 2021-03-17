module Catalogue
  class LivresController < ApplicationController
    def initialize
      super
      @rails_adapter = Catalogue::RailsControllerAdapter.new(self)
      @livre_service = Catalogue::LivreService.new(@rails_adapter)
    end

    def index
      @view_model = @livre_service.afficher_livres
    end

    def new
      @form = @livre_service.creer_livre
    end

    def create
      @view_model = @livre_service.enregistrer_livre

      render status: :bad_request if @view_model.erreurs.any?
    end

    def search
      @view_model, @form = @livre_service.rechercher_livre

      render status: :not_found if @view_model.livres.empty?
    end
  end
end
