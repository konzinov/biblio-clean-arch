module Biblio
  module Domain
    module UseCases
      class EnregistrerLivre < UseCase
        param :livre_repository
        
        
        def execute(enregistrer_live_request)
          errors = validate_demande enregistrer_live_request
          return response_class.build(message: 'Erreurs rencontrées', errors: errors) if errors.any?
          
          livre = Entities::Livre.new(enregistrer_live_request.titre,
                            enregistrer_live_request.auteur,
                            enregistrer_live_request.nb_pages,
                            enregistrer_live_request.date_publication)


          
          if livre_repository.save(livre)
            response_class.build(message: 'Livre enregistré avec success')
          else
            response_class.build(message: 'Enregistrement du livre impossible', errors: {db: 'repository error'})
          end
        end
        
        def validate_demande(demande_creation_livre)
          errors = {}
          
          errors[:titre] = 'Titre absent' if demande_creation_livre.titre.nil? || demande_creation_livre.titre.empty?
          errors
        end
        
        def response_class
          Biblio::ResponseModels::EnregistrerLivreResponse
        end
        
      end
    end
  end
end
