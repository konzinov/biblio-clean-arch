module Biblio
  module Catalogue
    module ResponseModels
      class EnregistrerLivreResponse < Response
        option :livre, default: proc { nil }
        option :errors, default: proc { {} }
      end
    end
  end
end
