module UseCases
  class EnregistrerLivre < UseCase
    param :livre_repository, default: proc { Database::Container.resolve(:livre_repository) }

    def execute(enregistrer_livre_request, presenter)
      errors = validate_request_model(enregistrer_livre_request)
      if errors.any?
        response = response_model.build(errors: errors)
        return presenter.present(response)
      end

      livre = Entities::Livre.new(**request_model.dry_initializer.attributes(enregistrer_livre_request))
      save_errors = {}
      save_errors[:db] = 'repository error' unless livre_repository.save(livre)
      response = response_model.build(livre: livre, errors: save_errors)
      presenter.present(response)
    end

    protected

    def request_model
      EnregistrerLivreRequest
    end

    def response_model
      EnregistrerLivreResponse
    end

    def validate_request_model(enregistrer_live_request)
      {}.tap do |errors|
        errors[:titre] = 'Titre absent' if enregistrer_live_request.titre.nil? || enregistrer_live_request.titre.empty?
      end
    end
  end
end
