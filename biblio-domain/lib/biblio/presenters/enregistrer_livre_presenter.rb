module Biblio
  module Presenters
    class EnregistrerLivrePresenter < Presenter

      def present(enregistrer_livre_response)
        erreurs = []

        if enregistrer_livre_response.failure?
          enregistrer_livre_response.errors.keys.each do |key|
            erreurs << "#{key.to_s.upcase}: #{enregistrer_livre_response.errors[key]}"
          end
          message = "Echec de l'enregistrement du livre"
        else
          message = 'Livre enregistré avec succès'
          livre = view_model::Livre.new(**Domain::Entities::Livre.dry_initializer.attributes(enregistrer_livre_response.livre))
        end

        view_model.new(message, livre: livre, erreurs: erreurs)
      end

      def view_model
        ViewModels::EnregistrerLivreViewModel
      end
    end
  end
end