module Biblio
  module Domain
    module UseCases
      class EnregistrerLivre < UseCase
        param :livre_repository
        
        def execute(enregistrer_live_request, presenter)
          errors = validate_demande enregistrer_live_request
          response = if errors.any?
                      response_model.build(errors: errors)
                    else
                      livre = Entities::Livre.new(enregistrer_live_request.titre,
                                                  enregistrer_live_request.auteur,
                                                  enregistrer_live_request.nb_pages,
                                                  enregistrer_live_request.date_publication)

                      if livre_repository.save(livre)
                        response_model.build(livre: livre)
                      else
                        response_model.build(livre: livre, errors: {db: 'repository error'})
                      end
                    end
          presenter.present(response)
        end
        
        def validate_demande(demande_creation_livre)
          errors = {}
          errors[:titre] = 'Titre absent' if demande_creation_livre.titre.nil? || demande_creation_livre.titre.empty?
          errors
        end
        
        def response_model
          Biblio::ResponseModels::EnregistrerLivreResponse
        end
      end
    end
  end
end
