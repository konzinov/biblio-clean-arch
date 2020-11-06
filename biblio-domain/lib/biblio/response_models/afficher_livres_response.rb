module Biblio::ResponseModels
  class AfficherLivresResponse < Response
    param :livres, default: proc { [] }
  end
end