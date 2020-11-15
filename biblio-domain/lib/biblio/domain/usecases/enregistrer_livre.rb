module Biblio
  module Domain
    module UseCases
      class EnregistrerLivre < UseCase
        param :livre_repository

        def execute(enregistrer_live_request, presenter)
          errors = validate_request_model(enregistrer_live_request)
          response = if errors.any?
                       response_model.build(errors: errors)
                     else
                       livre = Entities::Livre.new(**Biblio::RequestModels::EnregistrerLivreRequest.dry_initializer.attributes(enregistrer_live_request))

                       if livre_repository.save(livre)
                         response_model.build(livre: livre)
                       else
                         response_model.build(livre: livre, errors: { db: 'repository error' })
                       end
                     end

          presenter.present(response)
        end

        private

        def validate_request_model(enregistrer_live_request)
          errors = {}
          errors[:titre] = 'Titre absent' if enregistrer_live_request.titre.nil? || enregistrer_live_request.titre.empty?
          errors
        end

        def response_model
          Biblio::ResponseModels::EnregistrerLivreResponse
        end
      end
    end
  end
end
