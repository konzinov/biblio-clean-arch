require 'dry-initializer'
require 'dry-equalizer'

require 'biblio/domain/version'
require 'biblio/domain/entities/livre'
require 'biblio/domain/usecases/use_case'
require 'biblio/domain/usecases/enregistrer_livre'
require 'biblio/domain/usecases/rechercher_livre'

require 'biblio/request_models/enregistrer_livre_request'
require 'biblio/request_models/rechercher_livre_request'

require 'biblio/response_models/response'
require 'biblio/response_models/enregistrer_livre_response'
require 'biblio/response_models/rechercher_livre_response'

require 'biblio/adapters/livre_repository'
require 'biblio/adapters/livre_in_memory_repository'

module Biblio
  module Domain
    class Error < StandardError; end
    # Your code goes here...
  end
end
