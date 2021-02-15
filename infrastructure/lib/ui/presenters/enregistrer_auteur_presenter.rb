module Presenters
  class EnregistrerAuteurPresenter < Presenter
    def present(enregistrer_auteur_response)
      erreurs = []

      if enregistrer_auteur_response.failure?
        enregistrer_auteur_response.errors.each_key do |key|
          erreurs << "#{key.to_s.upcase}: #{enregistrer_auteur_response.errors[key]}"
        end
        message = "Echec de l'enregistrement de l'auteur"
      else
        # puts enregistrer_auteur_response.auteur.nom
        auteur = view_model::Auteur.new(**Entities::Auteur.dry_initializer.attributes(enregistrer_auteur_response.auteur))
        message = 'Auteur enregistré avec succès'
      end

      # puts auteur.nom
      view_model.new(message, auteur: auteur, erreurs: erreurs)
    end

    protected

    def view_model
      ViewModels::EnregistrerAuteurViewModel
    end
  end
end
