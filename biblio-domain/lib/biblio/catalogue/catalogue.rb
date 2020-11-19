require_relative 'entities/livre'
require_relative 'usecases/use_case'
require_relative 'usecases/enregistrer_livre'
require_relative 'usecases/rechercher_livre'
require_relative 'usecases/afficher_livres'

require_relative 'request_models/enregistrer_livre_request'
require_relative 'request_models/rechercher_livre_request'

require_relative 'response_models/response'
require_relative 'response_models/afficher_livres_response'
require_relative 'response_models/enregistrer_livre_response'
require_relative 'response_models/rechercher_livre_response'

require_relative 'view_models/view_model'
require_relative 'view_models/afficher_livres_view_model'
require_relative 'view_models/enregistrer_livre_view_model'
require_relative 'view_models/rechercher_livre_view_model'

require_relative 'presenters/presenter'
require_relative 'presenters/afficher_livres_presenter'
require_relative 'presenters/enregistrer_livre_presenter'
require_relative 'presenters/rechercher_livre_presenter'

require_relative 'adapters/livre_repository'
require_relative 'adapters/livre_in_memory_repository'
