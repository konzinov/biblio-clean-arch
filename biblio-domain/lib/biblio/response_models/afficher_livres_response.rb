module Biblio
  module ResponseModels
    class AfficherLivresResponse < Response
      param :livres, default: proc { [] }
    end
  end
end
