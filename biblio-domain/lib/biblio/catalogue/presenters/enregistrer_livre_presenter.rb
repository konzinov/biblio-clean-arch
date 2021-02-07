module Biblio
  module Catalogue
    module Presenters
      class EnregistrerLivrePresenter < Presenter
        def present(enregistrer_livre_response)
          erreurs = []

          if enregistrer_livre_response.failure?
            enregistrer_livre_response.errors.each_key do |key|
              erreurs << "#{key.to_s.upcase}: #{enregistrer_livre_response.errors[key]}"
            end
            message = "Echec de l'enregistrement du livre"
          else
            livre = view_model::Livre.new(**Entities::Livre.dry_initializer.attributes(enregistrer_livre_response.livre))
            message = 'Livre enregistré avec succès'
          end

          view_model.new(message, livre: livre, erreurs: erreurs)
        end

        protected

        def view_model
          ViewModels::EnregistrerLivreViewModel
        end
      end
    end
  end
end
