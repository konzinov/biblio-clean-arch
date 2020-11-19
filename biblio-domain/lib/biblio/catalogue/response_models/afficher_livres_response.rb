module Biblio
  module Catalogue
    module ResponseModels
      class AfficherLivresResponse < Response
        param :livres, default: proc { [] }
      end
    end
  end
end
