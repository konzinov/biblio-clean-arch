require 'dry-initializer'
require 'dry-equalizer'

require 'biblio/domain/version'
require 'biblio/domain/entities/livre'
require 'biblio/domain/usecases/use_case'
require 'biblio/domain/usecases/enregistrer_livre'
require 'biblio/domain/usecases/rechercher_livre'
require 'biblio/domain/usecases/afficher_livres'

require 'biblio/request_models/enregistrer_livre_request'
require 'biblio/request_models/rechercher_livre_request'

require 'biblio/response_models/response'
require 'biblio/response_models/afficher_livres_response'
require 'biblio/response_models/enregistrer_livre_response'
require 'biblio/response_models/rechercher_livre_response'

require 'biblio/view_models/view_model'
require 'biblio/view_models/afficher_livres_view_model'
require 'biblio/view_models/enregistrer_livre_view_model'

require 'biblio/presenters/presenter'
require 'biblio/presenters/afficher_livres_presenter'
require 'biblio/presenters/enregistrer_livre_presenter'

require 'biblio/adapters/livre_repository'
require 'biblio/adapters/livre_in_memory_repository'

module Biblio
  module Domain
    class Error < StandardError; end
    # Your code goes here...
  end
end
