module Catalogue
  class AuteursController < ApplicationController
    include Biblio::Catalogue

    def initialize
      super
      @rails_adapter = Catalogue::RailsControllerAdapter.new(self)
      @livre_service = Catalogue::AuteurService.new(@rails_adapter)
    end

    def index
      @view_model = @auteur_service.afficher_auteurs
    end

    def new
      @form = @auteur_service.creer_auteur
    end

    def create
      @view_model = @auteur_service.enregistrer_auteur

      render status: :bad_request if @view_model.erreurs.any?
    end

    def search
      @view_model, @form = @auteur_service.rechercher_auteur

      render status: :not_found if @view_model.auteurs.empty?
    end
  end
end
