module Biblio
  module Catalogue
    module UseCases
      class EnregistrerAuteur < UseCase
        param :auteur_repository, default: proc { Biblio::Db::Container.resolve(:auteur_repository) }

        def execute(enregistrer_auteur_request, presenter)
          errors = validate_request_model(enregistrer_auteur_request)
          if errors.any?
            response = response_model.build(errors: errors)
            return presenter.present(response)
          end

          auteur = Entities::Auteur.new(**request_model.dry_initializer.attributes(enregistrer_auteur_request))

          save_errors = {}
          save_errors[:db] = 'repository error' unless auteur_repository.save(auteur)
          response = response_model.build(auteur: auteur, errors: save_errors)
          presenter.present(response)
        end

        protected

        def request_model
          RequestModels::EnregistrerAuteurRequest
        end

        def response_model
          ResponseModels::EnregistrerAuteurResponse
        end

        def validate_request_model(enregistrer_auteur_request)
          {}.tap do |errors|
            errors[:nom] = 'Nom auteur absent' if enregistrer_auteur_request.nom.nil? || enregistrer_auteur_request.nom.empty?
          end
        end
      end
    end
  end
end
